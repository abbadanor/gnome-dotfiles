##
# Project Title
#
# @file
# @version 0.1

all:
	stow --verbose --target=$$HOME --restow */
delete:
	stow --verbose --target=$$HOME --delete */
#root:
	#stow --verbose --target=/ --restow */root/

# end
