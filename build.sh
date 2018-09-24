#!/bin/bash
repos="vm image"
allversion="61 70"
prefix="pharo-"
user="jvalteren"

if [ "$(uname -s)" = 'Linux' ]; then
	readlinkcmd="readlink -f"
else
	echo "Assuming Homebrew with packages installed: coreutils"
	readlinkcmd="greadlink -f"
fi

cd "$(dirname "$($readlinkcmd -f "$BASH_SOURCE")")"

versions="$@"
if [ "$versions" = "" ]; then
        versions="$allversion"
fi

default="slim64"
variants="slim slim64"
for repo in $repos; do
	for version in $versions; do
		for variant in $variants; do
			dir="$repo/$version/$variant"
			tag="$prefix$repo:$version-$variant"
			echo "BUILDING $tag";
			
			(cd $dir && docker build -t "$user/$tag" .)
			docker push "$user/$tag"
			if [ "$variant" = "$default" ]; then
				docker tag "$user/$tag" "$user/$prefix$repo:$version"
				docker push "$user/$prefix$repo:$version"
			fi
		done
	done
done

