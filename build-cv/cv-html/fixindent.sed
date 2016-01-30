# Change indentations to form definition lists pandoc can understand

# Remove div tags
s~^</\?div.*~~g
#
# Insert 4 spaces after definition colon : 
s/^\:\s\+/:    /g 
#
# Change item year to @year@ temporarily
s/^\([0-9]\{4\}\)$/@\1@/g 
#
# Insert 4 space indent in all other lines 
s/^\([^:@]\)/    \1/g 
#
# Remove temporary edit of item year
s/^@\([0-9]\{4\}\)@/\1/g 

