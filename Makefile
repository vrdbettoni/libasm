# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    Makefile                                         .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2019/12/17 12:50:53 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/06 18:45:28 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

NAME		=	libasm.a

CC			=	gcc
NASM		=	nasm
INCL		=	libasm.h
INCLB		=	libasm_bonus.h
FLAG		=	-Wall -Wextra -Werror
N_FLAGS		=	-f macho64

SRCS_PATH	=	srcs
OBJS_PATH	=	objs
INCL_PATH	=	includes

OBJ			=	$(addprefix $(OBJS_PATH)/, $(SRCS:.s=.o))
OBJS		=	$(addprefix $(OBJS_PATH)/, $(SRCS:.s=.o) $(BONUS:.s=.o))
INCLS		=	$(addprefix $(INCL_PATH)/, $(INCL))
SRCS		=	ft_write.s							ft_read.s\
				ft_strlen.s							ft_strcpy.s\
				ft_strdup.s							ft_strcmp.s
BONUS		=	ft_list_size_bonus.s				ft_print_data_bonus.s\
				ft_list_push_front_bonus.s			ft_list_remove_if_bonus.s\
				ft_list_sort_bonus.s				ft_atoi_base_bonus.s\


all:		$(NAME)

#----------------------- COMP MAIN -------------------------------------#

test:		all
			@$(CC) $(FLAG) $(NAME) ./main/main.c
			@echo "\033[32m > \033[1m./a.out\033[0;32m create !\033[0m"

test_bonus:	bonus
			@$(CC) $(FLAG) $(NAME) ./main/main_bonus.c
			@echo "\033[32m > \033[1m./a.out\033[0;32m create !\033[0m"

#----------------------- .S -> .O --------------------------------------#

bonus:		$(OBJS)
			@ar r $(NAME) $(OBJS) 2>/dev/null || true
			@echo "\033[32m > \033[1m$(NAME)\033[0;32m create !\033[0m"

$(NAME):	$(OBJ)
			@ar r $(NAME) $(OBJ) 2>/dev/null || true
			@echo "\033[32m > \033[1m$(NAME)\033[0;32m create !\033[0m"



$(OBJS_PATH)/%.o:	$(SRCS_PATH)/%.s
					@$(shell mkdir -p $(OBJS_PATH))
					@$(NASM) $(N_FLAGS) -s $< -o $@

clean:
			@rm -rf $(OBJS_PATH)
			@echo "\033[31m > \033[1m$(OBJS_PATH)/*\033[0;31m delete.\033[0m"

fclean:		clean
			@rm -rf $(NAME)
			@rm -rf ./a.out.dSYM ./a.out
			@echo "\033[31m > \033[1m$(NAME)\033[0;31m delete.\033[0m"

re:			fclean all

.PHONY:		all clean fclean re
