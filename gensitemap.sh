#!/bin/bash
cd /var/www

wget -O /dev/null http://brmlab.cz/doku.php?do=sitemap

SITEMAP=""
for i in *.html *.html; do
  SITEMAP="$SITEMAP
  <url>
    <loc>https://brmlab.cz/$i</loc>
    <lastmod>$(date -Iseconds -d @$(stat -c %Y $i))</lastmod>
  </url>"
done
#SITEMAP="$SITEMAP
#</urlset>"

echo "Static pages that will be appended to sitemap: $SITEMAP"
echo "$SITEMAP" > sitemap-static.tmp

(zcat data/cache/sitemap.xml.gz; echo "") | sed -e "/<\\/urlset/ {r sitemap-static.tmp" -e 'N}' | gzip > sitemap.xml.gz
