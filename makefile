##
# Project Title
#
# @file
# @version 0.1

all:
	stow --verbose --no-folding --target=$$HOME --restow */
delete:
	stow --verbose --no-folding --target=$$HOME --delete */
# end
