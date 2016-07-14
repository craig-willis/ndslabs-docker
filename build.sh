#APISERVER=172.17.0.3
APISERVER=localhost
TAG=$1
CONTEXT=$2

echo -n "Username: "
read USERNAME
echo -n "Password: "
read -s PASSWORD
echo

TOKEN=`curl -s -d "{\"username\": \"$USERNAME\", \"password\": \"$PASSWORD\"}" -H "Content-Type:application/json" http://$APISERVER:30001/api/authenticate | jq -r '.token'`

HEADERS=("--header" "Authorization: Bearer ${TOKEN}" "--header" "Content-Type: application/json")

#curl  "${HEADERS[@]}"  http://172.17.0.3:30001/api/services

# curl "${HEADERS[@]}" -X PUT --data @project.json http://localhost:8083/projects/demo/project
echo -n "Docker username: "
read DUSERNAME
echo -n "Docker password: "
read -s DPASSWORD
echo

echo "Building..."
curl -X POST -H "Authorization: Bearer $token"  http://$APISERVER:30001/api/build?context=$CONTEXT&tag=$TAG&user=$DUSERNAME&password=$DPASSWORD
