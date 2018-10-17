kubectl create secret docker-registry ocirsecret \
  --docker-server=iad.ocir.io \
  --docker-username='@@YOUR TENANCY@@/@@YOUR USERNAME@@' \
  --docker-password='@@YOUR AUTH TOKEN@@' \
  --docker-email='@@YOUR EMAIL@@'
