BASE_URI=$1
PATH_TO_EVENTS_APP=${2:-"$HOME/eventsappstart/"}
SITE_PATH=$PATH_TO_EVENTS_APP/events-website/views/layouts/default.hbs
if [ -z "$1" ]
then 
    echo "Usage: $0 <ECR base URI> <path/to/eventsappstart/>(optional)"
    exit
fi

build_tag_and_push() {
    repo_name=$1
    tag=$2
    app_path=${3:-$repo_name}
    docker build -f ${repo_name}.dockerfile ${PATH_TO_EVENTS_APP}${app_path}/ -t ${repo_name}
    docker tag ${repo_name}:latest ${BASE_URI}/${repo_name}:${tag}
    docker push ${BASE_URI}/${repo_name}:${tag}
}

edit_website() {
    cp $SITE_PATH $SITE_PATH.bak
    search_str="Events App"
    repl_str="Events App \*\*Version 2\.0\*\*"

    sed "s/${search_str}/${repl_str}/" $SITE_PATH -i
}

un_edit_website() {
    mv $SITE_PATH.bak $SITE_PATH
}

VALUES_PATH='../helm/events-app/values.yaml'
edit_values() {
    sed -i "s/<website-repo-here>/$BASE_URI\/events-website/" $VALUES_PATH
    sed -i "s/<api-repo-here>/$BASE_URI\/events-api/" $VALUES_PATH
    sed -i "s/<job-repo-here>/$BASE_URI\/events-job/" $VALUES_PATH
}


build_tag_and_push 'events-job' 'v1.0' 'database-initializer'
build_tag_and_push 'events-api' 'v1.0' 
build_tag_and_push 'events-website' 'v1.0' 

edit_website
build_tag_and_push 'events-website' 'v2.0' 
un_edit_website

edit_values



