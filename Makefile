# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CC := gcc
CFLAGS := -I./boringssl/include -L./boringssl/build/crypto -lcrypto -lpthread
OBJS = c/util.o c/issue.o c/redeem.o c/key_generator.o
MAIN = bin/main
.SUFFIXES: .c .o

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

all: main

main: $(OBJS) c/config.h
	$(CC) c/main.c -static -o $(MAIN) $(OBJS) $(CFLAGS)

example: c/example.c c/config.h
	$(CC) c/example.c -static -o ./bin/example c/util.o $(CFLAGS)
	./bin/example

.PHONY: generate_key, clean, test
generate_key:
	$(MAIN) --key-generate

test:
	$(MAIN) --issue AAMEpmE5Mg3KAqlAh3BaBMxHMqY9kHvMBrP+EhA+772dleG4/FmneD0evZbGsNKdA24ARfD/Rk3AiPscif9ybnNOwAarUC8202Y9sgnm3oCdpc1yNlqQgHkW+cLb9CDGqkB1BHuOaDAZqSo084VCXoQqOb6wbySjDlKzlOBdhX8v6jxJdhVA6K/usdz5IuiDDgAODNUIUGwriuJz469s1Ui/tn0oGlimkQ771u8EjWaeq/iLMzA53ohQEP2QiBxkBl4S/ATOJ64Mrlify6IE3XJb6dqpO4EEztArabm5rAiY6RJK7Ay8vqrcCJcOHR/X/nPLtfXxg2k4IeAwpyUgSQGhJR4Su7YbhDl87t2uTB+PGwBpHtJvoS2sF70fBXdK9c1RIj4=

clean:
	$(RM) $(OBJS) bin/*
