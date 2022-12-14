#all_branches
branch_names=$(git branch -r | cut -c 10- | tail -n +2)

#arr=$(git branch -r | cut -c 10- | tail -n +2)
for branch in $branch_names
do
echo $branch
if [ "$branch" = "production" ]; then 
    #count=$(git tag -l |wc -l)
    #tag_arr=$(git tag -l)
    echo "production branch"
    #docker build -t nest-sample-app:$tag .
    docker build -t nest-sample-app:$tag_arr .
    break
else
    echo "other branch"
    docker build -t nest-sample-app:$branch .
    sleep 5
fi;
echo "1"
done
