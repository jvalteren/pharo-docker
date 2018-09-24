#!/bin/bash

repos="vm image"
allversion="61 70"

if [ "$(uname -s)" = 'Linux' ]; then
	sedcmd="sed -r"
	readlinkcmd="readlink -f"
else
	echo "Assuming Homebrew with packages installed: gnu-sed coreutils"
	sedcmd="gsed -r"
	readlinkcmd="greadlink -f"
fi

cd "$(dirname "$($readlinkcmd "$BASH_SOURCE")")"

versions="$@"
if [ "$versions" = "" ]; then
	versions="$allversion"
fi

generated_warning() {
	cat <<-EOH
		#
		# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
		#
		# PLEASE DO NOT EDIT IT DIRECTLY.
		#
	EOH
}

variants="slim slim64"
for repo in $repos; do
	for version in $versions; do
		for variant in $variants; do
			dir="$repo/$version/$variant"
			echo $dir
			template="Dockerfile-$repo-$variant.template"
			mkdir -p "$dir"
			sedStr="
				s!%%VERSION%%!$version!g;
			"
			{ generated_warning; cat "$template"; } > "$dir/Dockerfile"
			$sedcmd "$sedStr" -i "$dir/Dockerfile"
		done
	done
done
