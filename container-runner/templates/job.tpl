apiVersion: batch/v1
kind: Job
metadata:
  name: actions-runner-job
  labels:
    environment: {{ .Values.ENVIRONMENT }}
    organisation: {{ .Values.ORGANISATION }}
    repository:  {{ .Values.REPOSITORY }}
spec:
  template:
    spec:
      containers:
      - name: {{ .Values.APP_NAME }}
        image: {{ .Values.IMAGE_NAME }}
        imagePullPolicy: IfNotPresent
        env: 
          - name: ORGANISATION
            value: {{ .Values.ORGANISATION }}
          - name: REPOSITORY 
            value: {{ .Values.REPOSITORY }}
          - name: GITHUB_PAT
            valueFrom:
              secretKeyRef:
                name: github-pat
                key: pat-token
          - name: ENVIRONMENT
            value: {{ .Values.ENVIRONMENT }}
      restartPolicy: Never 
  backoffLimit: 1

