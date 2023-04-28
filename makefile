##
# Project Title
#
# @file
# @version 0.1

all:
	stow -v -R --no-folding --ignore="\.*.nostow" --target=$$HOME */
delete:
	stow -v --no-folding --ignore="\.*.nostow" --target=$$HOME --delete */
# end
