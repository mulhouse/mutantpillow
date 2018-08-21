# icon ? for PWA ? 
# favicon ? 

OUTFILE="./index.html"

cat > $OUTFILE<<'EOT'

<!DOCTYPE html>
<html lang="en" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml">
<head prefix="og: http://ogp.me/ns#">
	<title>[SITE TITLE]</title>

	<meta charset="utf-8" />
    <meta name="theme-color" content="black" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<meta name="description" content="[BAND DESCRIPTION]" />
	<meta http-equiv="content-language" content="en_US" />
	<meta name="language" content="en_US" />

	<meta property="og:title" content="[TITLE FOR FB SHARING]" />
	<meta property="og:type" content="music.album" />
	<meta property="og:url" content="[URL FOR FB SHARING]" />
	<meta property="og:description" content="[DESC FOR FB SHARING]" />
	<meta property="og:image" content="[IMAGE FOR FB SHARING]" />
	<meta property="og:image:secure_url" content="[FOR FB SHARING]" />
	<meta property="og:image:width" content="[FOR FB SHARING]" />
	<meta property="og:image:height" content="[FOR FB SHARING]" />
	<meta property="og:image:type" content="image/jpeg">
	<meta property="og:audio" content="[FOR FB SHARING]" />
	<meta property="og:audio:url" content="[FOR FB SHARING]" />
	<meta property="og:audio:secure_url" content="[FOR FB SHARING]">
	<meta property="og:audio:type" content="audio/mpeg">	
	<meta property="fb:app_id" content="[FB APP_ID FOR STATS]" />

	<link rel="icon" type="image/jpeg" href="index.jpg" />
	<link rel="manifest" href="/manifest.json">
	<link href="https://fonts.googleapis.com/css?family=Walter+Turncoat" rel="stylesheet"> 
	<style type="text/css">
		body {	
			font-family:'Walter Turncoat', cursive;
			color: yellow; 
			background-color: black;
			background-image: url(images/index.jpg);   
		    background-size: 100%;	
			}
		h1 {font-size: 2.5em; text-align: center}
		h2 {background-color: rgba(255,255,0,0.5); color:red;}
		li {list-style-type: upper-roman; color: yellow;}
		a {color: yellow}
		a:hover {background-color: yellow; color: red;}
		audio {transition:all 0.3s linear; border-radius:9px 9px 9px 9px ;}
		audio:hover, audio:focus, audio:active {transform: scale(1.10);}
	</style>
</head>
<body>
<h1>[PAGE TITLE]</h1>
<p>[BAND DESCRIPTION]</p>
EOT

cd ./audio
for dir in */
do
    dir=${dir%/}		# strip trailing /
 #   dir=${dir##*/}		# strip path & leading / (useless here)
    echo $dir
echo "<h2>"$dir"</h2><ol>" >> ../$OUTFILE
    cd "$dir"
	for file in *.mp3
	do
		name=$(echo "$file" | cut -f 1 -d '.')
		echo "   "$file
		title=$(echo "${name:3:${#name}}")	#strip first 3 chars (tracks #)
		echo "<li><a href=\"audio/"$dir"/"$file"\" download>"$title"</a></li>" >> ../../$OUTFILE
		echo "<audio controls><source src=\"audio/"$dir"/"$file"\" type=\"audio/mpeg\">" >> ../../$OUTFILE
		echo "This browser doesn't support mp3 playing : install firefox !</audio>" >> ../../$OUTFILE
	done
	echo "</ol>" >> ../../$OUTFILE
	cd ..
done
cat >> ../$OUTFILE<<'EOT'


<p>
	<a href="https://github.com/[USER]/[REPO]]/archive/master.zip">Download</a> all songs !<br>
	<a href="mailto:[EMAIL]?subject=[SUBJECT]">Write</a> to the band !<br>
	<a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fr"><img src="https://licensebuttons.net/l/by-nc-sa/3.0/88x31.png"></a>
</p>

<script type="text/javascript">
/* Stops all others players when play */	
document.addEventListener('play', function(e){
    var audios = document.getElementsByTagName('audio');
    for(var i = 0, len = audios.length; i < len;i++){
        if(audios[i] != e.target){
            audios[i].pause();
        }
    }
}, true);

/* Starts next player when one song has ended 
	without resetting time to zero*/
document.addEventListener('ended', function(e){
    var audios = document.getElementsByTagName('audio');
    for(var i = 0, len = audios.length; i < len;i++){
        if(audios[i] == e.target){
            audios[i+1].play();
        }
    }
}, true);

/* empty SW for add to homescreen prompt on android devices */
if ('serviceWorker' in navigator) {
  console.log("Will service worker register?");
  navigator.serviceWorker.register('service-worker.js').then(function(reg){
    console.log("Yes it did.");
  }).catch(function(err) {
    console.log("No it didn't. This happened: ", err)
  });
}
</script>
</body>
</html>
EOT

