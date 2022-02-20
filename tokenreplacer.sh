if [ -z $1 ]
then
  echo 'usage: tokenreplacer <token>' 
  exit 1
fi

git remote get-url origin
if [ $? != 0 ]
then
  echo "There is no git remote url orign information in the current directory!"
  exit 1
fi

replace_to=$(echo $(git remote get-url origin) | sed -r "s/\/\/.+@/\/\/$1@/g")
echo $?
echo "Current remote url: $(git remote get-url origin)"
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
