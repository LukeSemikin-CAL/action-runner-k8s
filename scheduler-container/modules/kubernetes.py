from random import choice
from json import loads
from kubernetes import client, config, watch

class K8sScheduler:

    def __init__ (self):
        config.load_incluster_config()
        self.v1=client.CoreV1Api()
        self.scheduler_name = "runner-scheduler"

    def pod_name(self):
        hex_digits = '0123456789ABCDEF'
        return 'github-runner-'.join(choice(hex_digits) for _ in range (6))

    def available_nodes(self):
        available_nodes = []
        for node in self.v1.list_node().items:
            for status in node.status.conditions:
                if status.status == "True" and status.type == "Ready":
                    available_nodes.append(node.metadata.name)
        return available_nodes()
    
    def pod_create(self, name, node, namespace="<namespace>"):
        body=client.V1Binding()    
        target=client.V1ObjectReference()
        target.kind="Node"
        target.apiVersion="v1"
        target.name= node
        meta = client.V1ObjectMeta()
        meta.name=name
        body.target=target
        body.metadata=meta
        return self.v1.create_namespaced_binding_binding(name, namespace, body)
    
    def pod_scheduler(self, namespace):
        watcher = watch.Watch() 
        for event in watcher.stream(self.v1.list_namespaced_pod, namespace):
            if event['object'].spec.scheduler_name == self.scheduler_name:
                try:
                    self.pod_create(
                        name=self.pod_name(),
                        node=choice(self.available_nodes()),
                        namespace=namespace
                    )
                except client.rest.ApiException as e:
                    print(loads(e.body)['message'])


    




