##############################################################################
#  ocaml-fileutils: files and filenames common operations                    #
#                                                                            #
#  Copyright (C) 2003-2014, Sylvain Le Gall                                  #
#                                                                            #
#  This library is free software; you can redistribute it and/or modify it   #
#  under the terms of the GNU Lesser General Public License as published by  #
#  the Free Software Foundation; either version 2.1 of the License, or (at   #
#  your option) any later version, with the OCaml static compilation         #
#  exception.                                                                #
#                                                                            #
#  This library is distributed in the hope that it will be useful, but       #
#  WITHOUT ANY WARRANTY; without even the implied warranty of                #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the file         #
#  COPYING for more details.                                                 #
#                                                                            #
#  You should have received a copy of the GNU Lesser General Public License  #
#  along with this library; if not, write to the Free Software Foundation,   #
#  Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA             #
##############################################################################

default: test

build:
	dune build

doc:
	dune build @doc

test: build
	dune runtest

all:
	dune build @all

install: all
	dune install

uninstall:
	dune uninstall

clean:
	dune clean

.PHONY: build doc test all install uninstall clean

# Headache target
#  Fix license header of file.

headache:
	find ./ \
		-name _darcs -prune -false -o \
		-name .git -prune -false -o \
		-name _build -prune -false -o \
		-type f \
		| xargs headache -h _header -c _headache.config

.PHONY: headache

# Deploy target
#  Deploy/release the software.

deploy: doc
	dune-release tag
	git push --all
	git push --tag
	dune-release

.PHONY: deploy
