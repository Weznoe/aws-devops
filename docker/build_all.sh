BASE_URI=$1
if [ -z "$1" ]
then 
    echo "Usage: $0 <ECR base URI> <path/to/eventsappstart/>(optional)"
    exit
fi
PATH_TO_EVENTS_APP=${2:-"$HOME/eventsappstart/"}


build_tag_and_push() {
    repo_name=$1
    tag=$2
    app_path=${3:-$repo_name}
    docker build -f ${repo_name}.dockerfile ${PATH_TO_EVENTS_APP}${app_path}/ -t events-job
    docker tag ${repo_name}:latest ${BASE_URI}/${repo_name}:${tag}
    docker push ${BASE_URI}/${repo_name}:${tag}
}

build_tag_and_push 'events-job' 'v1.0' 'database-initializer/'
build_tag_and_push 'events-api' 'v1.0' 
build_tag_and_push 'events-website' 'v1.0' 

