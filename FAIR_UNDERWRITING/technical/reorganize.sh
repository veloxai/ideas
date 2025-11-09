#!/bin/bash

# Create subdirectories
mkdir -p product-features
mkdir -p research-platform
mkdir -p infrastructure
mkdir -p operations
mkdir -p business
mkdir -p implementation
mkdir -p organizational

# Move files to appropriate directories
mv PRODUCT_*.md product-features/ 2>/dev/null
mv RESEARCH_*.md research-platform/ 2>/dev/null
mv INFRASTRUCTURE_*.md infrastructure/ 2>/dev/null
mv OPERATIONS_*.md operations/ 2>/dev/null
mv BUSINESS_*.md business/ 2>/dev/null
mv IMPLEMENTATION_*.md implementation/ 2>/dev/null
mv ORGANIZATIONAL_*.md organizational/ 2>/dev/null
mv CULTURE_*.md organizational/ 2>/dev/null
mv ONBOARDING_*.md organizational/ 2>/dev/null

# Keep master index at root
# MASTER_FEATURE_INDEX.md stays here

echo "Reorganization complete!"
echo ""
echo "New structure:"
echo "  product-features/     - 27 product feature docs"
echo "  research-platform/    - 11 research platform docs"
echo "  infrastructure/       - 3 infrastructure docs"
echo "  operations/           - 3 operations docs"
echo "  business/             - 3 business docs"
echo "  implementation/       - 3 implementation roadmap docs"
echo "  organizational/       - 3 change management docs"
echo "  MASTER_FEATURE_INDEX.md - stays at root"
