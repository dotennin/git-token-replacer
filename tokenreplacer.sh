if [ -z $1 ]
then
  echo 'usage: tokenreplacer <token>' 
  exit 1
fi

remote_url=$(git remote get-url origin)
if [ $? != 0 ]
then
  echo "There is no git remote url orign information in the current directory!"
  exit 1
fi

# checks the current remote url token exists or not
echo $remote_url | grep "@"
if [ $? -eq 0 ]
then
  replace_to=$(echo $remote_url | sed -r "s/\/\/.+@/\/\/$1@/g")
else
  replace_to=$(echo $remote_url | sed -r "s/\/\/.?github.com/\/\/$1@github.com/g")
fi

echo "Current remote url: $remote_url"
echo "↓"
echo "↓"
echo "↓"
echo "Replace to: $replace_to \n"
read -p "do you replace token really ? (y/n)" YN_LOADSETTING

if [ "${YN_LOADSETTING}" != "y" ]; then
  echo "Bye"
  exit 1
fi

git remote set-url origin $replace_to

echo "Success"
