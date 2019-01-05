# Docker image with awscli, kubectl and some utils

## Usage

```yaml
---
kind: CronJob
apiVersion: batch/v1beta1
metadata:
  name: update-ecr-secret

spec:
  schedule: "30 */3 * * *"
  jobTemplate:
    spec:
      template:
        spec:
          restartPolicy: OnFailure
          containers:
          - name: updater
            image: zzzsochi/kubeawsctl
            command: ["/usr/local/bin/update_ecr_secret"]
            env:
            - name: KUBE_TOKEN
              valueFrom:
                secretKeyRef:
                  name: drone-token-kxbqc
                  key: token
            - name: AWS_ACCESS_KEY_ID
              valueFrom:
                secretKeyRef:
                  name: aws
                  key: id
            - name: AWS_SECRET_ACCESS_KEY
              valueFrom:
                secretKeyRef:
                  name: aws
                  key: secret
            - name: AWS_DEFAULT_REGION
              valueFrom:
                secretKeyRef:
                  name: aws
                  key: region

            - name: ECR_REGISTRY
              value: 682366063701.dkr.ecr.us-east-2.amazonaws.com
            - name: KUBE_ECR_SECRET_NAME
              value: ecr
```

## /usr/local/bin/kubesetup

Setup ``kubectl``. Need to set ``KUBE_TOKEN`` variable.

```bash
docker run -it --rm -e KUBE_TOKEN=$(kubectl get secret my-super-token -o jsonpath='{.data.token}') zzzsochi@kubeawsctl
kubesetup
kubectl get all
```

Variable ``KUBE_SERVER`` set the kubernates server. Default: ``https://kubernetes.default.svc.cluster.local``

## /usr/local/bin/update_ecr_secret

Need to set ``KUBE_TOKEN``, ``ECR_REGISTRY`` and ``KUBE_ECR_SECRET_NAME``.
Also you need to setup ``awscli`` environtment variables:

* ``AWS_ACCESS_KEY_ID``
* ``AWS_SECRET_ACCESS_KEY``
* ``AWS_DEFAULT_REGION``
