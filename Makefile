.DEFAULT_GOAL := all

EX00 = ft_print_program_name
EX01 = ft_print_params
EX02 = ft_rev_params
EX03 = ft_sort_params

norminette:
	-norminette ./ex00/${EX00}.c
	-norminette ./ex01/${EX01}.c
	-norminette ./ex02/${EX02}.c
	-norminette ./ex03/${EX03}.c

compile: norminette
	-gcc ./ex00/${EX00}.c -Wall -Werror -Wextra -o test_ex00_${EX00}
	-gcc ./ex01/${EX01}.c -Wall -Werror -Wextra -o test_ex01_${EX01}
	-gcc ./ex02/${EX02}.c -Wall -Werror -Wextra -o test_ex02_${EX02}
	-gcc ./ex03/${EX03}.c -Wall -Werror -Wextra -o test_ex03_${EX03}

build-sample: compile
	-./test_ex00_${EX00} > result_sample_ex00_${EX00}.txt
	-./test_ex01_${EX01} aaa bbb ccc > result_sample_ex01_${EX01}.txt
	-./test_ex02_${EX02} aaa bbb ccc > result_sample_ex02_${EX02}.txt
	-./test_ex03_${EX03} ddd bbb aaa ccc > result_sample_ex03_${EX03}.txt

run:	compile
	-./test_ex00_${EX00} > result_current_ex00_${EX00}.txt
	-./test_ex01_${EX01} aaa bbb ccc > result_current_ex01_${EX01}.txt
	-./test_ex02_${EX02} aaa bbb ccc > result_current_ex02_${EX02}.txt
	-./test_ex03_${EX03} ddd bbb aaa ccc > result_current_ex03_${EX03}.txt

all:	norminette	compile run

test:	all
	-diff result_current_ex00_${EX00}.txt result_sample_ex00_${EX00}.txt
	-diff result_current_ex01_${EX01}.txt result_sample_ex01_${EX01}.txt
	-diff result_current_ex02_${EX02}.txt result_sample_ex02_${EX02}.txt
	-diff result_current_ex03_${EX03}.txt result_sample_ex03_${EX03}.txt

clean:
	-rm -rf */*.out
	-rm -rf result_current_ex*.txt
	-rm test_ex00_${EX00}
	-rm test_ex01_${EX01}
	-rm test_ex02_${EX02}
	-rm test_ex03_${EX03}

clean-sample:
	-rm -rf result_sample_ex*.txt

clean-before-push-with-sample: clean
	-git add .
	-git commit -m "Build Sample Complete"
	-git push origin master
