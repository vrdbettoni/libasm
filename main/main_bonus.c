/* ************************************************************************** */
/*                                                          LE - /            */
/*                                                              /             */
/*   main.c                                           .::    .:/ .      .::   */
/*                                                 +:+:+   +:    +:  +:+:+    */
/*   By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+     */
/*                                                 #+#   #+    #+    #+#      */
/*   Created: 2019/12/17 15:45:03 by vroth-di     #+#   ##    ##    #+#       */
/*   Updated: 2020/01/06 18:44:07 by vroth-di    ###    #+. /#+    ###.fr     */
/*                                                         /                  */
/*                                                        /                   */
/* ************************************************************************** */

#include "../includes/libasm_bonus.h"

t_list		*ft_lstnew(void *content)
{
	t_list *list;

	list = malloc(sizeof(*list));
	if (list == NULL)
		return (NULL);
	list->data = content;
	list->next = NULL;
	return (list);
}

void		ft_lstclear(t_list **lst)
{
	t_list	*tmp;

	if (!lst)
		return ;
	while (*lst)
	{
		tmp = *lst;
		free(tmp->data);
		*lst = tmp->next;
		free(tmp);
	}
	*lst = NULL;
}

void		ft_lstadd_back(t_list **alst, t_list *new)
{
	t_list *tmp;

	if	 (!alst || !new)
		return ;
	if (!(*alst))
	{
		new->next = NULL;
		*alst = new;
		return ;
	}
	tmp = *alst;
	while (tmp->next != NULL)
		tmp = tmp->next;
	tmp->next = new;
}

int			ft_lstsize(t_list *lst)
{
	int size;

	size = 0;
	if (lst == NULL)
		return (size);
	while (lst != NULL)
	{
		size++;
		lst = lst->next;
	}
	return (size);
}

int		main()
{
	int		fd = open("text.txt", O_RDONLY);
	char	*buffer = calloc(sizeof(char), 100);

	printf("\n~ Test write ~\n");
	int p =  ft_write(1, "bonjour", 7);
	printf("\nret write-> %d", p);

	printf("\n\n~ Test read ~\n");
	p = ft_read(fd, buffer, 1000);
	printf("Retour read-> %d", p);
	printf("\n%s", buffer);

	printf("\n~Test strlen~\n");
	printf("%lu\n", ft_strlen(buffer));

	char *s1 = strdup("Si au bout de cette phrase il y a un point, ceci est strcpy valide.");
	char s2[100];
	printf("\n~Test strcpy~\n");
	printf("%s\n", ft_strcpy(s2, s1));
	free(s1);

	const char *s3 = "bonjour, ceci est un strdup";
	printf("\n~Test strdup~\n");
	char *s4 = ft_strdup((char*)s3);
	printf("%s\n", s4);
	free(s4);

	printf("\n~Test strcmp~\n");
	s3 = strdup("oOoOoOoOoOoOoOo");
	const char *s5 = strdup("oOoOoOoOoOoOoOo");
	printf("%d", strcmp(s3, s5));
	printf(" | %d\n", ft_strcmp(s3, NULL));


	t_list		**deb;
	t_list		*first;
	t_list		*second;
	t_list		*third;
	t_list		*fourth;

	printf("\n~Test list_size~\n");
	if (!(deb = malloc(sizeof(t_list**))))
		return (0);
	first = ft_lstnew(strdup("bonjour"));
	second = ft_lstnew(strdup("good morming"));
	third = ft_lstnew(strdup("guten tag"));
	fourth = ft_lstnew(strdup("buongiorno"));
	*deb = first;
	ft_lstadd_back(deb, second);
	ft_lstadd_back(deb, third);
	ft_lstadd_back(deb, fourth);
	printf("%d\n", ft_list_size(*deb));


	printf("\n~Test ft_print_data~\n");
	ft_print_data(*deb);

	printf("\n~Test list_push_front~\n");
	ft_list_push_front(deb, strdup("ola"));
	ft_print_data(*deb);

	printf("\n~Test list_remove_if~\n");
	ft_list_remove_if(deb, "bonjour", &strcmp, &free);
	ft_print_data(*deb);

	printf("\n~Test list_sort~\n");
	printf("\n~Avant~\n");
	ft_print_data(*deb);
	printf("\n~Apres~\n");
	ft_list_sort(deb, &strcmp);
	ft_print_data(*deb);

	printf("\n~Test atoi_base~\n");
	p =  ft_atoi_base("12345", "0e3456789abcd1f");
	printf("%d\n", p);

	free((char*)s3);
	free((char*)s5);
	free(buffer);
	ft_lstclear(deb);
	free(deb);
	close(fd);
	return (0);
}
