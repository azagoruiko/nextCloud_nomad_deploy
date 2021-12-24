DOCKER_REPO="192.168.0.21:9999/docker"
VER=0.0.8
export NOMAD_ADDR="http://192.168.0.21:4646"
if [ ! -e $1 ]; then
    VER=$1
fi
export VER
echo $VER
DOCKER_TAG="${DOCKER_REPO}/nextcloud:${VER}"
echo $DOCKER_TAG

docker build -t "$DOCKER_TAG" -f Dockerfile .
docker push "$DOCKER_TAG"

nomad job run nextcloud.nomad
