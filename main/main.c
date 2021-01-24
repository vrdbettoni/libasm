/* ************************************************************************** */
/*                                                          LE - /            */
/*                                                              /             */
/*   main.c                                           .::    .:/ .      .::   */
/*                                                 +:+:+   +:    +:  +:+:+    */
/*   By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+     */
/*                                                 #+#   #+    #+    #+#      */
/*   Created: 2019/12/17 15:45:03 by vroth-di     #+#   ##    ##    #+#       */
/*   Updated: 2020/01/08 20:17:24 by vroth-di    ###    #+. /#+    ###.fr     */
/*                                                         /                  */
/*                                                        /                   */
/* ************************************************************************** */

#include "../includes/libasm.h"

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
	printf(" | %d\n", ft_strcmp(s3, s5));

	free((char*)s3);
	free((char*)s5);
	free(buffer);
	close(fd);
	return (0);
}
