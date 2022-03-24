#!/bin/bash

echo "PASTIKAN TIDAK ADA SPASI PADA NAMA BERKAS/FOLDER"

cat > index.html  << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Files</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body class="text-white" style="background: #262626;">
<div class="container p-3 pt-5">
EOF
echo "<h4 class=\"\">Berbagi Berkas Surge.sh</h4><hr>" >> index.html
echo "<h5 class=\"\">Daftar Berkas</h5><div style='height:2px; width:25px; background:#55acee; margin-bottom:10px'></div>" >> index.html
echo "<ul class=\"list-unstyled\">" >> index.html
for data in *; do
    if [[ ! -d $data ]]; then
        if [[ $data == 'index.'* ]]; then
            echo "Skipping"
        else 
            echo "Berkas: $data"
            echo -e  "<li class='ms-4'><a class=\"text-decoration-none text-light\" href=./$data>📃  $data</a></li>" >> index.html
        fi
    fi
done
echo "</ul>" >> index.html

echo "<h5 class=\"\">Daftar File dalam Direktori</h5><div style='height:2px; width:25px; background:#55acee; margin-bottom:10px'></div>" >> index.html
for data in *; do
    echo "<ul class=\"list-unstyled\">" >> index.html
    if [[ -d $data ]]; then
        echo -e "<p class='ms-4 m-0'>📂  $data </p>" >> index.html; 
        echo "Folder: $data"
        for file in $data/*; do
            cd $data
            echo "  Berkas: $file"
            fileName=$(echo $file | cut -d '/' -f2)
            echo -e  "<li class='ms-5'><a class=\"text-decoration-none text-light\" href=\"./$file\">📃  $fileName </a></li>" >> ../index.html; 
            cd ..
        done
    fi
    echo "</ul class=\"mb-3\">" >> index.html
done


echo -e '</div>\n</body>\n</html>' >> index.html; 

cat >> index.html << EOF
<section class="py-4 pt-5 text-light" style="background: #262626;">
    <div class="container">
        <div>
            <p class="text-center"><strong>Surge for File Sharing </strong><br />Created with<strong> ❤️</strong> by <a class="text-light" href="https://raniaamina.id"><strong>Rania Amina</strong></a></p>
        </div>
    </div>
</section>
EOF

which nvm use node 

if [[ -z "$1" ]]; then
    PID=$(echo $USER | tr -d ' ')
    URL=$(echo "$PID-$RANDOM.surge.sh")
    surge . $URL
else
    URL=$1
    surge . $URL
fi

echo "Halaman dipublikasikan di $URL"