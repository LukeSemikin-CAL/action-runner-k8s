apiVersion: batch/v1
kind: Job
metadata:
  name: github-runner
  labels:
    app: {{ .Values.APP_NAME }}
spec:
  template:
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
      restartPolicy: Never 
  backoffLimit: 1
