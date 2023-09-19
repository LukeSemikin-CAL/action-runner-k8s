apiVersion: apps/v1
kind: Deployment
metadata:
  name: actions-runner-deployment
  labels:
    app: {{ .Values.APP_NAME }}
spec: 
  replicas: 1
  selector:
    matchLabels:
      app: {{ .Values.APP_NAME }}
  template:
    metadata:
      labels:
        app: {{ .Values.APP_NAME }}
    spec:
      containers:
        - name: {{ .Values.APP_NAME }}
          image: {{ .Values.IMAGE_NAME }}
          imagePullPolicy: IfNotPresent
          env: 
            - name: ORGANISATION
              value: {{ .Values.env.ORGANISATION }}
            - name: REPOSITORY 
              value: {{ .Values.env.REPOSITORY }}
            - name: GITHUB_PAT
              valueFrom:
                secretKeyRef:
                  name: github-pat
                  key: pat-token
            - name: ENVIRONMENT
              value: {{ .Values.env.ENVIRONMENT }}
