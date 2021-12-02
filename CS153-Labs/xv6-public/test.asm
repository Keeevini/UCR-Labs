
_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

#define WNOHANG 1

int main(int argc, char *argv[]){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 30             	sub    $0x30,%esp

	printf(1, "\nTest Program TEST\n");
   b:	c7 44 24 04 a8 07 00 	movl   $0x7a8,0x4(%esp)
  12:	00 
  13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1a:	e8 21 04 00 00       	call   440 <printf>

	int pid;
	int status = 10;
  1f:	c7 44 24 2c 0a 00 00 	movl   $0xa,0x2c(%esp)
  26:	00 

	pid = fork();
  27:	e8 be 02 00 00       	call   2ea <fork>
	if (pid) {
  2c:	85 c0                	test   %eax,%eax
  2e:	74 6f                	je     9f <main+0x9f>
		int secondPID = waitpid(pid, &status, 0);
  30:	8d 54 24 2c          	lea    0x2c(%esp),%edx
  34:	89 54 24 04          	mov    %edx,0x4(%esp)
  38:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  3f:	00 
  40:	89 04 24             	mov    %eax,(%esp)
  43:	e8 ba 02 00 00       	call   302 <waitpid>
		
		printf(1, "\nparent pid: %d child pid: %d status: %d", getpid(), secondPID, status);
  48:	8b 74 24 2c          	mov    0x2c(%esp),%esi
		int secondPID = waitpid(pid, &status, 0);
  4c:	89 c3                	mov    %eax,%ebx
		printf(1, "\nparent pid: %d child pid: %d status: %d", getpid(), secondPID, status);
  4e:	e8 27 03 00 00       	call   37a <getpid>
  53:	89 74 24 10          	mov    %esi,0x10(%esp)
  57:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  5b:	c7 44 24 04 d8 07 00 	movl   $0x7d8,0x4(%esp)
  62:	00 
  63:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6a:	89 44 24 08          	mov    %eax,0x8(%esp)
  6e:	e8 cd 03 00 00       	call   440 <printf>
		exit(0);

	}
	else {
		printf(1, "\nchild pid: %d status: %d", getpid(), status);
		sleep(2);
  73:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  7a:	e8 0b 03 00 00       	call   38a <sleep>
		printf(1, "\n");
  7f:	c7 44 24 04 ba 07 00 	movl   $0x7ba,0x4(%esp)
  86:	00 
  87:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  8e:	e8 ad 03 00 00       	call   440 <printf>
		exit(0);
  93:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  9a:	e8 53 02 00 00       	call   2f2 <exit>
		printf(1, "\nchild pid: %d status: %d", getpid(), status);
  9f:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  a3:	e8 d2 02 00 00       	call   37a <getpid>
  a8:	c7 44 24 04 bc 07 00 	movl   $0x7bc,0x4(%esp)
  af:	00 
  b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b7:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  bb:	89 44 24 08          	mov    %eax,0x8(%esp)
  bf:	e8 7c 03 00 00       	call   440 <printf>
  c4:	eb ad                	jmp    73 <main+0x73>
  c6:	66 90                	xchg   %ax,%ax
  c8:	66 90                	xchg   %ax,%ax
  ca:	66 90                	xchg   %ax,%ax
  cc:	66 90                	xchg   %ax,%ax
  ce:	66 90                	xchg   %ax,%ax

000000d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  d9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  da:	89 c2                	mov    %eax,%edx
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  e0:	83 c1 01             	add    $0x1,%ecx
  e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  e7:	83 c2 01             	add    $0x1,%edx
  ea:	84 db                	test   %bl,%bl
  ec:	88 5a ff             	mov    %bl,-0x1(%edx)
  ef:	75 ef                	jne    e0 <strcpy+0x10>
    ;
  return os;
}
  f1:	5b                   	pop    %ebx
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    
  f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000100 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
 106:	53                   	push   %ebx
 107:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 10a:	0f b6 02             	movzbl (%edx),%eax
 10d:	84 c0                	test   %al,%al
 10f:	74 2d                	je     13e <strcmp+0x3e>
 111:	0f b6 19             	movzbl (%ecx),%ebx
 114:	38 d8                	cmp    %bl,%al
 116:	74 0e                	je     126 <strcmp+0x26>
 118:	eb 2b                	jmp    145 <strcmp+0x45>
 11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 120:	38 c8                	cmp    %cl,%al
 122:	75 15                	jne    139 <strcmp+0x39>
    p++, q++;
 124:	89 d9                	mov    %ebx,%ecx
 126:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 129:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 12c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 12f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 133:	84 c0                	test   %al,%al
 135:	75 e9                	jne    120 <strcmp+0x20>
 137:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 139:	29 c8                	sub    %ecx,%eax
}
 13b:	5b                   	pop    %ebx
 13c:	5d                   	pop    %ebp
 13d:	c3                   	ret    
 13e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 141:	31 c0                	xor    %eax,%eax
 143:	eb f4                	jmp    139 <strcmp+0x39>
 145:	0f b6 cb             	movzbl %bl,%ecx
 148:	eb ef                	jmp    139 <strcmp+0x39>
 14a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000150 <strlen>:

uint
strlen(const char *s)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 156:	80 39 00             	cmpb   $0x0,(%ecx)
 159:	74 12                	je     16d <strlen+0x1d>
 15b:	31 d2                	xor    %edx,%edx
 15d:	8d 76 00             	lea    0x0(%esi),%esi
 160:	83 c2 01             	add    $0x1,%edx
 163:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 167:	89 d0                	mov    %edx,%eax
 169:	75 f5                	jne    160 <strlen+0x10>
    ;
  return n;
}
 16b:	5d                   	pop    %ebp
 16c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 16d:	31 c0                	xor    %eax,%eax
}
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    
 171:	eb 0d                	jmp    180 <memset>
 173:	90                   	nop
 174:	90                   	nop
 175:	90                   	nop
 176:	90                   	nop
 177:	90                   	nop
 178:	90                   	nop
 179:	90                   	nop
 17a:	90                   	nop
 17b:	90                   	nop
 17c:	90                   	nop
 17d:	90                   	nop
 17e:	90                   	nop
 17f:	90                   	nop

00000180 <memset>:

void*
memset(void *dst, int c, uint n)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 55 08             	mov    0x8(%ebp),%edx
 186:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 187:	8b 4d 10             	mov    0x10(%ebp),%ecx
 18a:	8b 45 0c             	mov    0xc(%ebp),%eax
 18d:	89 d7                	mov    %edx,%edi
 18f:	fc                   	cld    
 190:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 192:	89 d0                	mov    %edx,%eax
 194:	5f                   	pop    %edi
 195:	5d                   	pop    %ebp
 196:	c3                   	ret    
 197:	89 f6                	mov    %esi,%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001a0 <strchr>:

char*
strchr(const char *s, char c)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	53                   	push   %ebx
 1a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 1aa:	0f b6 18             	movzbl (%eax),%ebx
 1ad:	84 db                	test   %bl,%bl
 1af:	74 1d                	je     1ce <strchr+0x2e>
    if(*s == c)
 1b1:	38 d3                	cmp    %dl,%bl
 1b3:	89 d1                	mov    %edx,%ecx
 1b5:	75 0d                	jne    1c4 <strchr+0x24>
 1b7:	eb 17                	jmp    1d0 <strchr+0x30>
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1c0:	38 ca                	cmp    %cl,%dl
 1c2:	74 0c                	je     1d0 <strchr+0x30>
  for(; *s; s++)
 1c4:	83 c0 01             	add    $0x1,%eax
 1c7:	0f b6 10             	movzbl (%eax),%edx
 1ca:	84 d2                	test   %dl,%dl
 1cc:	75 f2                	jne    1c0 <strchr+0x20>
      return (char*)s;
  return 0;
 1ce:	31 c0                	xor    %eax,%eax
}
 1d0:	5b                   	pop    %ebx
 1d1:	5d                   	pop    %ebp
 1d2:	c3                   	ret    
 1d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <gets>:

char*
gets(char *buf, int max)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e5:	31 f6                	xor    %esi,%esi
{
 1e7:	53                   	push   %ebx
 1e8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 1eb:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1ee:	eb 31                	jmp    221 <gets+0x41>
    cc = read(0, &c, 1);
 1f0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1f7:	00 
 1f8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1fc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 203:	e8 0a 01 00 00       	call   312 <read>
    if(cc < 1)
 208:	85 c0                	test   %eax,%eax
 20a:	7e 1d                	jle    229 <gets+0x49>
      break;
    buf[i++] = c;
 20c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 210:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 212:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 215:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 217:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 21b:	74 0c                	je     229 <gets+0x49>
 21d:	3c 0a                	cmp    $0xa,%al
 21f:	74 08                	je     229 <gets+0x49>
  for(i=0; i+1 < max; ){
 221:	8d 5e 01             	lea    0x1(%esi),%ebx
 224:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 227:	7c c7                	jl     1f0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 229:	8b 45 08             	mov    0x8(%ebp),%eax
 22c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 230:	83 c4 2c             	add    $0x2c,%esp
 233:	5b                   	pop    %ebx
 234:	5e                   	pop    %esi
 235:	5f                   	pop    %edi
 236:	5d                   	pop    %ebp
 237:	c3                   	ret    
 238:	90                   	nop
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000240 <stat>:

int
stat(const char *n, struct stat *st)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	56                   	push   %esi
 244:	53                   	push   %ebx
 245:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 252:	00 
 253:	89 04 24             	mov    %eax,(%esp)
 256:	e8 df 00 00 00       	call   33a <open>
  if(fd < 0)
 25b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 25d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 25f:	78 27                	js     288 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 261:	8b 45 0c             	mov    0xc(%ebp),%eax
 264:	89 1c 24             	mov    %ebx,(%esp)
 267:	89 44 24 04          	mov    %eax,0x4(%esp)
 26b:	e8 e2 00 00 00       	call   352 <fstat>
  close(fd);
 270:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 273:	89 c6                	mov    %eax,%esi
  close(fd);
 275:	e8 a8 00 00 00       	call   322 <close>
  return r;
 27a:	89 f0                	mov    %esi,%eax
}
 27c:	83 c4 10             	add    $0x10,%esp
 27f:	5b                   	pop    %ebx
 280:	5e                   	pop    %esi
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	90                   	nop
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 288:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 28d:	eb ed                	jmp    27c <stat+0x3c>
 28f:	90                   	nop

00000290 <atoi>:

int
atoi(const char *s)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 4d 08             	mov    0x8(%ebp),%ecx
 296:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 297:	0f be 11             	movsbl (%ecx),%edx
 29a:	8d 42 d0             	lea    -0x30(%edx),%eax
 29d:	3c 09                	cmp    $0x9,%al
  n = 0;
 29f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2a4:	77 17                	ja     2bd <atoi+0x2d>
 2a6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2a8:	83 c1 01             	add    $0x1,%ecx
 2ab:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2ae:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2b2:	0f be 11             	movsbl (%ecx),%edx
 2b5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2b8:	80 fb 09             	cmp    $0x9,%bl
 2bb:	76 eb                	jbe    2a8 <atoi+0x18>
  return n;
}
 2bd:	5b                   	pop    %ebx
 2be:	5d                   	pop    %ebp
 2bf:	c3                   	ret    

000002c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2c0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c1:	31 d2                	xor    %edx,%edx
{
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	56                   	push   %esi
 2c6:	8b 45 08             	mov    0x8(%ebp),%eax
 2c9:	53                   	push   %ebx
 2ca:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2cd:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 2d0:	85 db                	test   %ebx,%ebx
 2d2:	7e 12                	jle    2e6 <memmove+0x26>
 2d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2df:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2e2:	39 da                	cmp    %ebx,%edx
 2e4:	75 f2                	jne    2d8 <memmove+0x18>
  return vdst;
}
 2e6:	5b                   	pop    %ebx
 2e7:	5e                   	pop    %esi
 2e8:	5d                   	pop    %ebp
 2e9:	c3                   	ret    

000002ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ea:	b8 01 00 00 00       	mov    $0x1,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <exit>:
SYSCALL(exit)
 2f2:	b8 02 00 00 00       	mov    $0x2,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <wait>:
SYSCALL(wait)
 2fa:	b8 03 00 00 00       	mov    $0x3,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <waitpid>:
SYSCALL(waitpid)
 302:	b8 16 00 00 00       	mov    $0x16,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <pipe>:
SYSCALL(pipe)
 30a:	b8 04 00 00 00       	mov    $0x4,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <read>:
SYSCALL(read)
 312:	b8 05 00 00 00       	mov    $0x5,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <write>:
SYSCALL(write)
 31a:	b8 10 00 00 00       	mov    $0x10,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <close>:
SYSCALL(close)
 322:	b8 15 00 00 00       	mov    $0x15,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <kill>:
SYSCALL(kill)
 32a:	b8 06 00 00 00       	mov    $0x6,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <exec>:
SYSCALL(exec)
 332:	b8 07 00 00 00       	mov    $0x7,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <open>:
SYSCALL(open)
 33a:	b8 0f 00 00 00       	mov    $0xf,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <mknod>:
SYSCALL(mknod)
 342:	b8 11 00 00 00       	mov    $0x11,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <unlink>:
SYSCALL(unlink)
 34a:	b8 12 00 00 00       	mov    $0x12,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <fstat>:
SYSCALL(fstat)
 352:	b8 08 00 00 00       	mov    $0x8,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <link>:
SYSCALL(link)
 35a:	b8 13 00 00 00       	mov    $0x13,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <mkdir>:
SYSCALL(mkdir)
 362:	b8 14 00 00 00       	mov    $0x14,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <chdir>:
SYSCALL(chdir)
 36a:	b8 09 00 00 00       	mov    $0x9,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <dup>:
SYSCALL(dup)
 372:	b8 0a 00 00 00       	mov    $0xa,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <getpid>:
SYSCALL(getpid)
 37a:	b8 0b 00 00 00       	mov    $0xb,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <sbrk>:
SYSCALL(sbrk)
 382:	b8 0c 00 00 00       	mov    $0xc,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <sleep>:
SYSCALL(sleep)
 38a:	b8 0d 00 00 00       	mov    $0xd,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <uptime>:
SYSCALL(uptime)
 392:	b8 0e 00 00 00       	mov    $0xe,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    
 39a:	66 90                	xchg   %ax,%ax
 39c:	66 90                	xchg   %ax,%ax
 39e:	66 90                	xchg   %ax,%ax

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	89 c6                	mov    %eax,%esi
 3a7:	53                   	push   %ebx
 3a8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	74 09                	je     3bb <printint+0x1b>
 3b2:	89 d0                	mov    %edx,%eax
 3b4:	c1 e8 1f             	shr    $0x1f,%eax
 3b7:	84 c0                	test   %al,%al
 3b9:	75 75                	jne    430 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3bb:	89 d0                	mov    %edx,%eax
  neg = 0;
 3bd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3c4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 3c7:	31 ff                	xor    %edi,%edi
 3c9:	89 ce                	mov    %ecx,%esi
 3cb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3ce:	eb 02                	jmp    3d2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 3d0:	89 cf                	mov    %ecx,%edi
 3d2:	31 d2                	xor    %edx,%edx
 3d4:	f7 f6                	div    %esi
 3d6:	8d 4f 01             	lea    0x1(%edi),%ecx
 3d9:	0f b6 92 0b 08 00 00 	movzbl 0x80b(%edx),%edx
  }while((x /= base) != 0);
 3e0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3e2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3e5:	75 e9                	jne    3d0 <printint+0x30>
  if(neg)
 3e7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 3ea:	89 c8                	mov    %ecx,%eax
 3ec:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 3ef:	85 d2                	test   %edx,%edx
 3f1:	74 08                	je     3fb <printint+0x5b>
    buf[i++] = '-';
 3f3:	8d 4f 02             	lea    0x2(%edi),%ecx
 3f6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 3fb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 3fe:	66 90                	xchg   %ax,%ax
 400:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 405:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 408:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 40f:	00 
 410:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 414:	89 34 24             	mov    %esi,(%esp)
 417:	88 45 d7             	mov    %al,-0x29(%ebp)
 41a:	e8 fb fe ff ff       	call   31a <write>
  while(--i >= 0)
 41f:	83 ff ff             	cmp    $0xffffffff,%edi
 422:	75 dc                	jne    400 <printint+0x60>
    putc(fd, buf[i]);
}
 424:	83 c4 4c             	add    $0x4c,%esp
 427:	5b                   	pop    %ebx
 428:	5e                   	pop    %esi
 429:	5f                   	pop    %edi
 42a:	5d                   	pop    %ebp
 42b:	c3                   	ret    
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 430:	89 d0                	mov    %edx,%eax
 432:	f7 d8                	neg    %eax
    neg = 1;
 434:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 43b:	eb 87                	jmp    3c4 <printint+0x24>
 43d:	8d 76 00             	lea    0x0(%esi),%esi

00000440 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 444:	31 ff                	xor    %edi,%edi
{
 446:	56                   	push   %esi
 447:	53                   	push   %ebx
 448:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 44b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 44e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 451:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 454:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 457:	0f b6 13             	movzbl (%ebx),%edx
 45a:	83 c3 01             	add    $0x1,%ebx
 45d:	84 d2                	test   %dl,%dl
 45f:	75 39                	jne    49a <printf+0x5a>
 461:	e9 c2 00 00 00       	jmp    528 <printf+0xe8>
 466:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 468:	83 fa 25             	cmp    $0x25,%edx
 46b:	0f 84 bf 00 00 00    	je     530 <printf+0xf0>
  write(fd, &c, 1);
 471:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 474:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47b:	00 
 47c:	89 44 24 04          	mov    %eax,0x4(%esp)
 480:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 483:	88 55 e2             	mov    %dl,-0x1e(%ebp)
  write(fd, &c, 1);
 486:	e8 8f fe ff ff       	call   31a <write>
 48b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 48e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 492:	84 d2                	test   %dl,%dl
 494:	0f 84 8e 00 00 00    	je     528 <printf+0xe8>
    if(state == 0){
 49a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 49c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 49f:	74 c7                	je     468 <printf+0x28>
      }
    } else if(state == '%'){
 4a1:	83 ff 25             	cmp    $0x25,%edi
 4a4:	75 e5                	jne    48b <printf+0x4b>
      if(c == 'd'){
 4a6:	83 fa 64             	cmp    $0x64,%edx
 4a9:	0f 84 31 01 00 00    	je     5e0 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4af:	25 f7 00 00 00       	and    $0xf7,%eax
 4b4:	83 f8 70             	cmp    $0x70,%eax
 4b7:	0f 84 83 00 00 00    	je     540 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4bd:	83 fa 73             	cmp    $0x73,%edx
 4c0:	0f 84 a2 00 00 00    	je     568 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4c6:	83 fa 63             	cmp    $0x63,%edx
 4c9:	0f 84 35 01 00 00    	je     604 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4cf:	83 fa 25             	cmp    $0x25,%edx
 4d2:	0f 84 e0 00 00 00    	je     5b8 <printf+0x178>
  write(fd, &c, 1);
 4d8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4db:	83 c3 01             	add    $0x1,%ebx
 4de:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e5:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4e6:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ec:	89 34 24             	mov    %esi,(%esp)
 4ef:	89 55 d0             	mov    %edx,-0x30(%ebp)
 4f2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 4f6:	e8 1f fe ff ff       	call   31a <write>
        putc(fd, c);
 4fb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 4fe:	8d 45 e7             	lea    -0x19(%ebp),%eax
 501:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 508:	00 
 509:	89 44 24 04          	mov    %eax,0x4(%esp)
 50d:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 510:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 513:	e8 02 fe ff ff       	call   31a <write>
  for(i = 0; fmt[i]; i++){
 518:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 51c:	84 d2                	test   %dl,%dl
 51e:	0f 85 76 ff ff ff    	jne    49a <printf+0x5a>
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
}
 528:	83 c4 3c             	add    $0x3c,%esp
 52b:	5b                   	pop    %ebx
 52c:	5e                   	pop    %esi
 52d:	5f                   	pop    %edi
 52e:	5d                   	pop    %ebp
 52f:	c3                   	ret    
        state = '%';
 530:	bf 25 00 00 00       	mov    $0x25,%edi
 535:	e9 51 ff ff ff       	jmp    48b <printf+0x4b>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 540:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 543:	b9 10 00 00 00       	mov    $0x10,%ecx
      state = 0;
 548:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 54a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 551:	8b 10                	mov    (%eax),%edx
 553:	89 f0                	mov    %esi,%eax
 555:	e8 46 fe ff ff       	call   3a0 <printint>
        ap++;
 55a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 55e:	e9 28 ff ff ff       	jmp    48b <printf+0x4b>
 563:	90                   	nop
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 568:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 56b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 56f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 571:	b8 04 08 00 00       	mov    $0x804,%eax
 576:	85 ff                	test   %edi,%edi
 578:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 57b:	0f b6 07             	movzbl (%edi),%eax
 57e:	84 c0                	test   %al,%al
 580:	74 2a                	je     5ac <printf+0x16c>
 582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 588:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 58b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 58e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 591:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 598:	00 
 599:	89 44 24 04          	mov    %eax,0x4(%esp)
 59d:	89 34 24             	mov    %esi,(%esp)
 5a0:	e8 75 fd ff ff       	call   31a <write>
        while(*s != 0){
 5a5:	0f b6 07             	movzbl (%edi),%eax
 5a8:	84 c0                	test   %al,%al
 5aa:	75 dc                	jne    588 <printf+0x148>
      state = 0;
 5ac:	31 ff                	xor    %edi,%edi
 5ae:	e9 d8 fe ff ff       	jmp    48b <printf+0x4b>
 5b3:	90                   	nop
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5b8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 5bb:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5bd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5c4:	00 
 5c5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c9:	89 34 24             	mov    %esi,(%esp)
 5cc:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 5d0:	e8 45 fd ff ff       	call   31a <write>
 5d5:	e9 b1 fe ff ff       	jmp    48b <printf+0x4b>
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
      state = 0;
 5e8:	66 31 ff             	xor    %di,%di
        printint(fd, *ap, 10, 1);
 5eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5f2:	8b 10                	mov    (%eax),%edx
 5f4:	89 f0                	mov    %esi,%eax
 5f6:	e8 a5 fd ff ff       	call   3a0 <printint>
        ap++;
 5fb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5ff:	e9 87 fe ff ff       	jmp    48b <printf+0x4b>
        putc(fd, *ap);
 604:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 607:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 609:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 60b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 612:	00 
 613:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 616:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 619:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 61c:	89 44 24 04          	mov    %eax,0x4(%esp)
 620:	e8 f5 fc ff ff       	call   31a <write>
        ap++;
 625:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 629:	e9 5d fe ff ff       	jmp    48b <printf+0x4b>
 62e:	66 90                	xchg   %ax,%ax

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 84 0a 00 00       	mov    0xa84,%eax
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 63e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 640:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 643:	39 d0                	cmp    %edx,%eax
 645:	72 11                	jb     658 <free+0x28>
 647:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 648:	39 c8                	cmp    %ecx,%eax
 64a:	72 04                	jb     650 <free+0x20>
 64c:	39 ca                	cmp    %ecx,%edx
 64e:	72 10                	jb     660 <free+0x30>
 650:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 652:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 654:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 656:	73 f0                	jae    648 <free+0x18>
 658:	39 ca                	cmp    %ecx,%edx
 65a:	72 04                	jb     660 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 65c:	39 c8                	cmp    %ecx,%eax
 65e:	72 f0                	jb     650 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 660:	8b 73 fc             	mov    -0x4(%ebx),%esi
 663:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 666:	39 cf                	cmp    %ecx,%edi
 668:	74 1e                	je     688 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 66a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 66d:	8b 48 04             	mov    0x4(%eax),%ecx
 670:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 673:	39 f2                	cmp    %esi,%edx
 675:	74 28                	je     69f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 677:	89 10                	mov    %edx,(%eax)
  freep = p;
 679:	a3 84 0a 00 00       	mov    %eax,0xa84
}
 67e:	5b                   	pop    %ebx
 67f:	5e                   	pop    %esi
 680:	5f                   	pop    %edi
 681:	5d                   	pop    %ebp
 682:	c3                   	ret    
 683:	90                   	nop
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 688:	03 71 04             	add    0x4(%ecx),%esi
 68b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 68e:	8b 08                	mov    (%eax),%ecx
 690:	8b 09                	mov    (%ecx),%ecx
 692:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 695:	8b 48 04             	mov    0x4(%eax),%ecx
 698:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 69b:	39 f2                	cmp    %esi,%edx
 69d:	75 d8                	jne    677 <free+0x47>
    p->s.size += bp->s.size;
 69f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 6a2:	a3 84 0a 00 00       	mov    %eax,0xa84
    p->s.size += bp->s.size;
 6a7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6aa:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6ad:	89 10                	mov    %edx,(%eax)
}
 6af:	5b                   	pop    %ebx
 6b0:	5e                   	pop    %esi
 6b1:	5f                   	pop    %edi
 6b2:	5d                   	pop    %ebp
 6b3:	c3                   	ret    
 6b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6cc:	8b 1d 84 0a 00 00    	mov    0xa84,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	8d 48 07             	lea    0x7(%eax),%ecx
 6d5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 6d8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6da:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 6dd:	0f 84 9b 00 00 00    	je     77e <malloc+0xbe>
 6e3:	8b 13                	mov    (%ebx),%edx
 6e5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6e8:	39 fe                	cmp    %edi,%esi
 6ea:	76 64                	jbe    750 <malloc+0x90>
 6ec:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 6f3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 6f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6fb:	eb 0e                	jmp    70b <malloc+0x4b>
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 700:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 702:	8b 78 04             	mov    0x4(%eax),%edi
 705:	39 fe                	cmp    %edi,%esi
 707:	76 4f                	jbe    758 <malloc+0x98>
 709:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 70b:	3b 15 84 0a 00 00    	cmp    0xa84,%edx
 711:	75 ed                	jne    700 <malloc+0x40>
  if(nu < 4096)
 713:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 716:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 71c:	bf 00 10 00 00       	mov    $0x1000,%edi
 721:	0f 43 fe             	cmovae %esi,%edi
 724:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 727:	89 04 24             	mov    %eax,(%esp)
 72a:	e8 53 fc ff ff       	call   382 <sbrk>
  if(p == (char*)-1)
 72f:	83 f8 ff             	cmp    $0xffffffff,%eax
 732:	74 18                	je     74c <malloc+0x8c>
  hp->s.size = nu;
 734:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 737:	83 c0 08             	add    $0x8,%eax
 73a:	89 04 24             	mov    %eax,(%esp)
 73d:	e8 ee fe ff ff       	call   630 <free>
  return freep;
 742:	8b 15 84 0a 00 00    	mov    0xa84,%edx
      if((p = morecore(nunits)) == 0)
 748:	85 d2                	test   %edx,%edx
 74a:	75 b4                	jne    700 <malloc+0x40>
        return 0;
 74c:	31 c0                	xor    %eax,%eax
 74e:	eb 20                	jmp    770 <malloc+0xb0>
    if(p->s.size >= nunits){
 750:	89 d0                	mov    %edx,%eax
 752:	89 da                	mov    %ebx,%edx
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 758:	39 fe                	cmp    %edi,%esi
 75a:	74 1c                	je     778 <malloc+0xb8>
        p->s.size -= nunits;
 75c:	29 f7                	sub    %esi,%edi
 75e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 761:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 764:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 767:	89 15 84 0a 00 00    	mov    %edx,0xa84
      return (void*)(p + 1);
 76d:	83 c0 08             	add    $0x8,%eax
  }
}
 770:	83 c4 1c             	add    $0x1c,%esp
 773:	5b                   	pop    %ebx
 774:	5e                   	pop    %esi
 775:	5f                   	pop    %edi
 776:	5d                   	pop    %ebp
 777:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 778:	8b 08                	mov    (%eax),%ecx
 77a:	89 0a                	mov    %ecx,(%edx)
 77c:	eb e9                	jmp    767 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 77e:	c7 05 84 0a 00 00 88 	movl   $0xa88,0xa84
 785:	0a 00 00 
    base.s.size = 0;
 788:	ba 88 0a 00 00       	mov    $0xa88,%edx
    base.s.ptr = freep = prevp = &base;
 78d:	c7 05 88 0a 00 00 88 	movl   $0xa88,0xa88
 794:	0a 00 00 
    base.s.size = 0;
 797:	c7 05 8c 0a 00 00 00 	movl   $0x0,0xa8c
 79e:	00 00 00 
 7a1:	e9 46 ff ff ff       	jmp    6ec <malloc+0x2c>
