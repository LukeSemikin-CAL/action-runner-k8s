apiVersion: apps/v1 
kind: Deployment
metadata:
  name: {{ .Values.APP_NAME }}-scheduler
  labels:
    app: {{ .Values.APP_NAME }}-scheduler
spec:
  replicas: 1
  selector:
    matchLabels: {{ .Values.APP_NAME }}
  template:
    metadata:
      labels:
        app: {{ .Values.APP_NAME }}-scheduler
    spec:
      containers:
        - name: {{ .Values.APP_NAME }}-scheduler
          images: {{ .Values.SCHEDULER_IMAGE_NAME }}
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
