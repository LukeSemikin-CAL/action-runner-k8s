apiVersion: apps/v1
kind: Deployment
metadata:
  name: github-runner-{{ .Values.env.REPOSITORY }}
  labels:
    app: {{ .Values.APP_NAME }}
spec: 
  schedulerName: runner-scheduler
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
