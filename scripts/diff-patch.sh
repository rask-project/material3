#/bin/bash

# This script is used to generate a patch file from the difference between two directories.
# The patch file can be used to apply the changes to another directory.

usage() {
    echo "Usage: $0 [options]
            Options:
                -d, --diff
                    Generate a diff file

                -p, --patch
                    Apply a patch file

                -s, --source
                    Source directory

                -t, --target
                    Target directory

                -h, --help
                    Display this message"
    exit 1
}

if [[ $# -eq 0 ]]; then
    usage
fi

while [[ $# -gt 0 ]]; do
    case $1 in
    -d|--diff)
        DIFF=ON
        shift
        ;;
    -p|--patch)
        PATCH=ON
        shift
        ;;
    -s|--source)
        SOURCE_DIR=$2
        shift 2
        ;;
    -t|--target)
        TARGET_DIR=$2
        shift 2
        ;;
    -h|--help)
        usage
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done

if [[ -z $DIFF && -z $PATCH ]]; then
    echo "Error: No operation specified (diff or patch)"
    usage
fi

OUTPUT_FILE=diff.patch

scriptDiff() {
    echo "Generating diff file..."
    diff -Naur $SOURCE_DIR $TARGET_DIR > $OUTPUT_FILE
    # diff -ruN $SOURCE_DIR $TARGET_DIR > $OUTPUT_FILE
}

scriptPatch() {
    echo "Applying patch file..."
    patch -ruN -d $TARGET_DIR < $OUTPUT_FILE
}

if [[ $DIFF == "ON" ]]; then
    if [[ -z $SOURCE_DIR || -z $TARGET_DIR ]]; then
        echo "Error: Source and target directories are required"
        usage
    fi
    scriptDiff
    exit 0
fi

if [[ $PATCH == "ON" ]]; then
    if [[ -z $TARGET_DIR ]]; then
        echo "Error: Target directory is required"
        usage
    fi
    scriptPatch
    exit 0
fi
