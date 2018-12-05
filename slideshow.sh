CDN='https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.6.0'
buildSlides="
jupyter nbconvert Análise.ipynb --to slides\
                                --SlidesExporter.reveal_theme=simple\
                                --reveal-prefix $CDN"


if [[ $1 = 'serve' ]]; then
	echo 'Serving slides'
	trap 'kill $entrId $serverId; rm index.html; reset; exit' SIGINT
	ls Análise.ipynb |\
		entr -s "$buildSlides && cp Análise.slides.html index.html" &
	
	entrId=$!
	python -m http.server 1>/dev/null &
	serverId=$!
	wait
else
	$buildSlides
fi