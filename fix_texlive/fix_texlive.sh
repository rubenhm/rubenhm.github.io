# Tug GPG keys are expired
# Option 1: add --verify-repo=none to install new packages
# tlmgr --verify-repo=none install beamer
# Option 2: update tlmgr
wget http://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh  
chmod +x update-tlmgr-latest.sh
./update-tlmgr-latest.sh

# The update or install missing packages
tlmgr install pdfescape

tlmgr install letltxmacro
tlmgr install bitset
