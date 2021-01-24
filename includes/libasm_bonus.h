/* ************************************************************************** */
/*                                                          LE - /            */
/*                                                              /             */
/*   libasm.h                                         .::    .:/ .      .::   */
/*                                                 +:+:+   +:    +:  +:+:+    */
/*   By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+     */
/*                                                 #+#   #+    #+    #+#      */
/*   Created: 2019/12/17 15:04:16 by vroth-di     #+#   ##    ##    #+#       */
/*   Updated: 2020/01/06 17:43:51 by vroth-di    ###    #+. /#+    ###.fr     */
/*                                                         /                  */
/*                                                        /                   */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <unistd.h>
# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <fcntl.h>

typedef struct		s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

ssize_t		ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t		ft_read(int fildes, void *buf, size_t nbyte);
size_t		ft_strlen(char *s);
char		*ft_strcpy(char *dst, const char *src);
char		*ft_strdup(const char *s1);
int			ft_atoi_base(char *str, char *base);
int			ft_strcmp(const char *s1, const char *s2);
int			ft_list_size(t_list *lst);
int			ft_print_data(t_list *lst);
void		ft_list_push_front(t_list **begin_list, void *data);
void		ft_list_sort(t_list **begin_list, int (*cmp)());
void		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(),
													void (*free_fct)(void *));

#endif
