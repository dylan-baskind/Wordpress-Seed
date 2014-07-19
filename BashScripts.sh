blogName="Riversend"
blogNameHyphen="riversend"

# Go to Blog Theme Folder
function rblog(){
	cd $serverFolder/$blogName/wp-content/themes/${blogName}_Theme
}

# Alias for Qwilr Blog
function ricons(){
	icons $blogNameHyphen /Users/ThomasNorth/Downloads/$blogNameHyphen $serverFolder/$blogName/wp-content/themes/${blogName}_Theme/Assets/Source/Styles/Include/IconFont
}

# Rsync this new deploy up to the live server
function rblog-deploy(){
	cd $serverFolder/$blogName
	growlnotify -t "$blogName Deployment" -m "Beginning RSYNC to Server"
	# Excluding GIT repo, node modules, the wp-config file and the Source files
	rsync -avz --progress --inplace --exclude='.git/' --exclude='wp-config.php' --exclude='wp-content/uploads/' --exclude="wp-content/themes/${blogName}_Theme/node_modules/" --exclude='node_modules/' --exclude='wp-content/themes/${blogName}_Theme/Assets/Source/' $serverFolder/$blogName/ admin@128.199.196.131:~/SERVER/$blogName
	growlnotify -t "$blogName Deployment" -m "RSYNC to server complete"
}

# Start PHP server for blog
function rblog-server(){
	cd $serverFolder/$blogName/
	php -S localhost:3100
}