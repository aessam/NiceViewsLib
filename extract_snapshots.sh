#!/bin/bash

# Script to extract snapshot images for documentation
# Run this after running the snapshot tests

SNAPSHOTS_DIR="NiceViewsTests/__Snapshots__/ViewSnapshotTests"
DOCS_DIR="Documentation/Images"

echo "🖼️  Extracting snapshots for documentation..."

# Create documentation directory if it doesn't exist
mkdir -p "$DOCS_DIR"

# Check if snapshots directory exists
if [ ! -d "$SNAPSHOTS_DIR" ]; then
    echo "❌ Snapshots directory not found. Please run the tests first."
    echo "   Run: xcodebuild test -scheme NiceViews"
    exit 1
fi

# Copy all snapshot images to documentation folder
echo "📁 Copying snapshots to $DOCS_DIR..."

find "$SNAPSHOTS_DIR" -name "*.png" -type f | while read -r file; do
    # Get the filename without path
    filename=$(basename "$file")
    # Remove the test prefix for cleaner names
    clean_name="${filename/test/}"
    clean_name="${clean_name/.1/}"
    clean_name="${clean_name/-light.1/-light}"
    clean_name="${clean_name/-dark.1/-dark}"
    
    cp "$file" "$DOCS_DIR/$clean_name"
    echo "   ✓ Copied $clean_name"
done

echo "✅ Snapshots extracted successfully!"
echo ""
echo "📝 You can now use these images in your README.md:"
echo ""

# Generate markdown image references
echo "<!-- Add these to your README.md -->"

# Group light and dark images together
processed_names=""
for image in "$DOCS_DIR"/*-light.png; do
    if [ -f "$image" ]; then
        base_name=$(basename "$image" -light.png)
        
        # Skip if already processed
        if [[ "$processed_names" == *"$base_name"* ]]; then
            continue
        fi
        processed_names="$processed_names $base_name"
        
        # Clean up the name for display
        display_name="${base_name//View/}"
        display_name="${display_name//-/ }"
        
        echo "### $display_name"
        echo ""
        echo "**Light Mode:**"
        echo "![${base_name} Light](Documentation/Images/${base_name}-light.png)"
        echo ""
        
        # Check if dark mode exists
        if [ -f "$DOCS_DIR/${base_name}-dark.png" ]; then
            echo "**Dark Mode:**"
            echo "![${base_name} Dark](Documentation/Images/${base_name}-dark.png)"
            echo ""
        fi
        echo "---"
        echo ""
    fi
done