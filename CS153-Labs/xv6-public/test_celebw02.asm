
_test_celebw02:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

#define WNOHANG 1

int main(int argc, char *argv[]) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 20             	sub    $0x20,%esp

	printf(1, "\nTest Program CELEBW02\n");
   b:	c7 44 24 04 d8 07 00 	movl   $0x7d8,0x4(%esp)
  12:	00 
  13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1a:	e8 51 04 00 00       	call   470 <printf>

	int pid, retpid;
	int status;

	if ((pid = fork()) < 0) {
  1f:	e8 f6 02 00 00       	call   31a <fork>
  24:	85 c0                	test   %eax,%eax
  26:	89 c3                	mov    %eax,%ebx
  28:	0f 88 97 00 00 00    	js     c5 <main+0xc5>
  2e:	66 90                	xchg   %ax,%ax
		printf(2, "Error on fork()");
	}
	else if (pid == 0) {
  30:	0f 84 a5 00 00 00    	je     db <main+0xdb>
  36:	8d 74 24 1c          	lea    0x1c(%esp),%esi
  3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		sleep(5);
		exit(1);
	}
	else do {
		if ((retpid = waitpid(pid, &status, WNOHANG)) == -1) {
  40:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  47:	00 
  48:	89 74 24 04          	mov    %esi,0x4(%esp)
  4c:	89 1c 24             	mov    %ebx,(%esp)
  4f:	e8 de 02 00 00       	call   332 <waitpid>
  54:	83 f8 ff             	cmp    $0xffffffff,%eax
  57:	74 4f                	je     a8 <main+0xa8>
			printf(2, "Error on wait()");
		
		}
		else if (retpid == 0) {
  59:	85 c0                	test   %eax,%eax
  5b:	75 23                	jne    80 <main+0x80>
			printf(1, "\nChild is still running");
  5d:	c7 44 24 04 10 08 00 	movl   $0x810,0x4(%esp)
  64:	00 
  65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6c:	e8 ff 03 00 00       	call   470 <printf>
			sleep(1);
  71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  78:	e8 3d 03 00 00       	call   3ba <sleep>
  7d:	eb c1                	jmp    40 <main+0x40>
  7f:	90                   	nop
		}
		else {
			printf(1, "\nChild exited with status of %d", status);
  80:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  84:	c7 44 24 04 28 08 00 	movl   $0x828,0x4(%esp)
  8b:	00 
  8c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  93:	89 44 24 08          	mov    %eax,0x8(%esp)
  97:	e8 d4 03 00 00       	call   470 <printf>
		}
	}
	while (retpid == 0);
	return 0;
}
  9c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  9f:	31 c0                	xor    %eax,%eax
  a1:	5b                   	pop    %ebx
  a2:	5e                   	pop    %esi
  a3:	5d                   	pop    %ebp
  a4:	c3                   	ret    
  a5:	8d 76 00             	lea    0x0(%esi),%esi
			printf(2, "Error on wait()");
  a8:	c7 44 24 04 00 08 00 	movl   $0x800,0x4(%esp)
  af:	00 
  b0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  b7:	e8 b4 03 00 00       	call   470 <printf>
}
  bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  bf:	31 c0                	xor    %eax,%eax
  c1:	5b                   	pop    %ebx
  c2:	5e                   	pop    %esi
  c3:	5d                   	pop    %ebp
  c4:	c3                   	ret    
		printf(2, "Error on fork()");
  c5:	c7 44 24 04 f0 07 00 	movl   $0x7f0,0x4(%esp)
  cc:	00 
  cd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  d4:	e8 97 03 00 00       	call   470 <printf>
  d9:	eb c1                	jmp    9c <main+0x9c>
		sleep(5);
  db:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  e2:	e8 d3 02 00 00       	call   3ba <sleep>
		exit(1);
  e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ee:	e8 2f 02 00 00       	call   322 <exit>
  f3:	66 90                	xchg   %ax,%ax
  f5:	66 90                	xchg   %ax,%ax
  f7:	66 90                	xchg   %ax,%ax
  f9:	66 90                	xchg   %ax,%ax
  fb:	66 90                	xchg   %ax,%ax
  fd:	66 90                	xchg   %ax,%ax
  ff:	90                   	nop

00000100 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 109:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 10a:	89 c2                	mov    %eax,%edx
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 110:	83 c1 01             	add    $0x1,%ecx
 113:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 117:	83 c2 01             	add    $0x1,%edx
 11a:	84 db                	test   %bl,%bl
 11c:	88 5a ff             	mov    %bl,-0x1(%edx)
 11f:	75 ef                	jne    110 <strcpy+0x10>
    ;
  return os;
}
 121:	5b                   	pop    %ebx
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 55 08             	mov    0x8(%ebp),%edx
 136:	53                   	push   %ebx
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 13a:	0f b6 02             	movzbl (%edx),%eax
 13d:	84 c0                	test   %al,%al
 13f:	74 2d                	je     16e <strcmp+0x3e>
 141:	0f b6 19             	movzbl (%ecx),%ebx
 144:	38 d8                	cmp    %bl,%al
 146:	74 0e                	je     156 <strcmp+0x26>
 148:	eb 2b                	jmp    175 <strcmp+0x45>
 14a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 150:	38 c8                	cmp    %cl,%al
 152:	75 15                	jne    169 <strcmp+0x39>
    p++, q++;
 154:	89 d9                	mov    %ebx,%ecx
 156:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 159:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 15c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 15f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 163:	84 c0                	test   %al,%al
 165:	75 e9                	jne    150 <strcmp+0x20>
 167:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 169:	29 c8                	sub    %ecx,%eax
}
 16b:	5b                   	pop    %ebx
 16c:	5d                   	pop    %ebp
 16d:	c3                   	ret    
 16e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 171:	31 c0                	xor    %eax,%eax
 173:	eb f4                	jmp    169 <strcmp+0x39>
 175:	0f b6 cb             	movzbl %bl,%ecx
 178:	eb ef                	jmp    169 <strcmp+0x39>
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000180 <strlen>:

uint
strlen(const char *s)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 186:	80 39 00             	cmpb   $0x0,(%ecx)
 189:	74 12                	je     19d <strlen+0x1d>
 18b:	31 d2                	xor    %edx,%edx
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	83 c2 01             	add    $0x1,%edx
 193:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 197:	89 d0                	mov    %edx,%eax
 199:	75 f5                	jne    190 <strlen+0x10>
    ;
  return n;
}
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 19d:	31 c0                	xor    %eax,%eax
}
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret    
 1a1:	eb 0d                	jmp    1b0 <memset>
 1a3:	90                   	nop
 1a4:	90                   	nop
 1a5:	90                   	nop
 1a6:	90                   	nop
 1a7:	90                   	nop
 1a8:	90                   	nop
 1a9:	90                   	nop
 1aa:	90                   	nop
 1ab:	90                   	nop
 1ac:	90                   	nop
 1ad:	90                   	nop
 1ae:	90                   	nop
 1af:	90                   	nop

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
 1b6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bd:	89 d7                	mov    %edx,%edi
 1bf:	fc                   	cld    
 1c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1c2:	89 d0                	mov    %edx,%eax
 1c4:	5f                   	pop    %edi
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <strchr>:

char*
strchr(const char *s, char c)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	53                   	push   %ebx
 1d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 1da:	0f b6 18             	movzbl (%eax),%ebx
 1dd:	84 db                	test   %bl,%bl
 1df:	74 1d                	je     1fe <strchr+0x2e>
    if(*s == c)
 1e1:	38 d3                	cmp    %dl,%bl
 1e3:	89 d1                	mov    %edx,%ecx
 1e5:	75 0d                	jne    1f4 <strchr+0x24>
 1e7:	eb 17                	jmp    200 <strchr+0x30>
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	38 ca                	cmp    %cl,%dl
 1f2:	74 0c                	je     200 <strchr+0x30>
  for(; *s; s++)
 1f4:	83 c0 01             	add    $0x1,%eax
 1f7:	0f b6 10             	movzbl (%eax),%edx
 1fa:	84 d2                	test   %dl,%dl
 1fc:	75 f2                	jne    1f0 <strchr+0x20>
      return (char*)s;
  return 0;
 1fe:	31 c0                	xor    %eax,%eax
}
 200:	5b                   	pop    %ebx
 201:	5d                   	pop    %ebp
 202:	c3                   	ret    
 203:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <gets>:

char*
gets(char *buf, int max)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 215:	31 f6                	xor    %esi,%esi
{
 217:	53                   	push   %ebx
 218:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 21b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 21e:	eb 31                	jmp    251 <gets+0x41>
    cc = read(0, &c, 1);
 220:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 227:	00 
 228:	89 7c 24 04          	mov    %edi,0x4(%esp)
 22c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 233:	e8 0a 01 00 00       	call   342 <read>
    if(cc < 1)
 238:	85 c0                	test   %eax,%eax
 23a:	7e 1d                	jle    259 <gets+0x49>
      break;
    buf[i++] = c;
 23c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 240:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 242:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 245:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 247:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 24b:	74 0c                	je     259 <gets+0x49>
 24d:	3c 0a                	cmp    $0xa,%al
 24f:	74 08                	je     259 <gets+0x49>
  for(i=0; i+1 < max; ){
 251:	8d 5e 01             	lea    0x1(%esi),%ebx
 254:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 257:	7c c7                	jl     220 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 259:	8b 45 08             	mov    0x8(%ebp),%eax
 25c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 260:	83 c4 2c             	add    $0x2c,%esp
 263:	5b                   	pop    %ebx
 264:	5e                   	pop    %esi
 265:	5f                   	pop    %edi
 266:	5d                   	pop    %ebp
 267:	c3                   	ret    
 268:	90                   	nop
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000270 <stat>:

int
stat(const char *n, struct stat *st)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	53                   	push   %ebx
 275:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 278:	8b 45 08             	mov    0x8(%ebp),%eax
 27b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 282:	00 
 283:	89 04 24             	mov    %eax,(%esp)
 286:	e8 df 00 00 00       	call   36a <open>
  if(fd < 0)
 28b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 28d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 28f:	78 27                	js     2b8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 291:	8b 45 0c             	mov    0xc(%ebp),%eax
 294:	89 1c 24             	mov    %ebx,(%esp)
 297:	89 44 24 04          	mov    %eax,0x4(%esp)
 29b:	e8 e2 00 00 00       	call   382 <fstat>
  close(fd);
 2a0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2a3:	89 c6                	mov    %eax,%esi
  close(fd);
 2a5:	e8 a8 00 00 00       	call   352 <close>
  return r;
 2aa:	89 f0                	mov    %esi,%eax
}
 2ac:	83 c4 10             	add    $0x10,%esp
 2af:	5b                   	pop    %ebx
 2b0:	5e                   	pop    %esi
 2b1:	5d                   	pop    %ebp
 2b2:	c3                   	ret    
 2b3:	90                   	nop
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2bd:	eb ed                	jmp    2ac <stat+0x3c>
 2bf:	90                   	nop

000002c0 <atoi>:

int
atoi(const char *s)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2c6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c7:	0f be 11             	movsbl (%ecx),%edx
 2ca:	8d 42 d0             	lea    -0x30(%edx),%eax
 2cd:	3c 09                	cmp    $0x9,%al
  n = 0;
 2cf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2d4:	77 17                	ja     2ed <atoi+0x2d>
 2d6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2d8:	83 c1 01             	add    $0x1,%ecx
 2db:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2de:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2e2:	0f be 11             	movsbl (%ecx),%edx
 2e5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2e8:	80 fb 09             	cmp    $0x9,%bl
 2eb:	76 eb                	jbe    2d8 <atoi+0x18>
  return n;
}
 2ed:	5b                   	pop    %ebx
 2ee:	5d                   	pop    %ebp
 2ef:	c3                   	ret    

000002f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2f1:	31 d2                	xor    %edx,%edx
{
 2f3:	89 e5                	mov    %esp,%ebp
 2f5:	56                   	push   %esi
 2f6:	8b 45 08             	mov    0x8(%ebp),%eax
 2f9:	53                   	push   %ebx
 2fa:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2fd:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 300:	85 db                	test   %ebx,%ebx
 302:	7e 12                	jle    316 <memmove+0x26>
 304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 308:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 30c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 30f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 312:	39 da                	cmp    %ebx,%edx
 314:	75 f2                	jne    308 <memmove+0x18>
  return vdst;
}
 316:	5b                   	pop    %ebx
 317:	5e                   	pop    %esi
 318:	5d                   	pop    %ebp
 319:	c3                   	ret    

0000031a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 31a:	b8 01 00 00 00       	mov    $0x1,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <exit>:
SYSCALL(exit)
 322:	b8 02 00 00 00       	mov    $0x2,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <wait>:
SYSCALL(wait)
 32a:	b8 03 00 00 00       	mov    $0x3,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <waitpid>:
SYSCALL(waitpid)
 332:	b8 16 00 00 00       	mov    $0x16,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <pipe>:
SYSCALL(pipe)
 33a:	b8 04 00 00 00       	mov    $0x4,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <read>:
SYSCALL(read)
 342:	b8 05 00 00 00       	mov    $0x5,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <write>:
SYSCALL(write)
 34a:	b8 10 00 00 00       	mov    $0x10,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <close>:
SYSCALL(close)
 352:	b8 15 00 00 00       	mov    $0x15,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <kill>:
SYSCALL(kill)
 35a:	b8 06 00 00 00       	mov    $0x6,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <exec>:
SYSCALL(exec)
 362:	b8 07 00 00 00       	mov    $0x7,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <open>:
SYSCALL(open)
 36a:	b8 0f 00 00 00       	mov    $0xf,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <mknod>:
SYSCALL(mknod)
 372:	b8 11 00 00 00       	mov    $0x11,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <unlink>:
SYSCALL(unlink)
 37a:	b8 12 00 00 00       	mov    $0x12,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <fstat>:
SYSCALL(fstat)
 382:	b8 08 00 00 00       	mov    $0x8,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <link>:
SYSCALL(link)
 38a:	b8 13 00 00 00       	mov    $0x13,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <mkdir>:
SYSCALL(mkdir)
 392:	b8 14 00 00 00       	mov    $0x14,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <chdir>:
SYSCALL(chdir)
 39a:	b8 09 00 00 00       	mov    $0x9,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <dup>:
SYSCALL(dup)
 3a2:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <getpid>:
SYSCALL(getpid)
 3aa:	b8 0b 00 00 00       	mov    $0xb,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <sbrk>:
SYSCALL(sbrk)
 3b2:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <sleep>:
SYSCALL(sleep)
 3ba:	b8 0d 00 00 00       	mov    $0xd,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <uptime>:
SYSCALL(uptime)
 3c2:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    
 3ca:	66 90                	xchg   %ax,%ax
 3cc:	66 90                	xchg   %ax,%ax
 3ce:	66 90                	xchg   %ax,%ax

000003d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	89 c6                	mov    %eax,%esi
 3d7:	53                   	push   %ebx
 3d8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3db:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3de:	85 db                	test   %ebx,%ebx
 3e0:	74 09                	je     3eb <printint+0x1b>
 3e2:	89 d0                	mov    %edx,%eax
 3e4:	c1 e8 1f             	shr    $0x1f,%eax
 3e7:	84 c0                	test   %al,%al
 3e9:	75 75                	jne    460 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3eb:	89 d0                	mov    %edx,%eax
  neg = 0;
 3ed:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3f4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 3f7:	31 ff                	xor    %edi,%edi
 3f9:	89 ce                	mov    %ecx,%esi
 3fb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3fe:	eb 02                	jmp    402 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 400:	89 cf                	mov    %ecx,%edi
 402:	31 d2                	xor    %edx,%edx
 404:	f7 f6                	div    %esi
 406:	8d 4f 01             	lea    0x1(%edi),%ecx
 409:	0f b6 92 4f 08 00 00 	movzbl 0x84f(%edx),%edx
  }while((x /= base) != 0);
 410:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 412:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 415:	75 e9                	jne    400 <printint+0x30>
  if(neg)
 417:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 41a:	89 c8                	mov    %ecx,%eax
 41c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 41f:	85 d2                	test   %edx,%edx
 421:	74 08                	je     42b <printint+0x5b>
    buf[i++] = '-';
 423:	8d 4f 02             	lea    0x2(%edi),%ecx
 426:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 42b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 42e:	66 90                	xchg   %ax,%ax
 430:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 435:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 438:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 43f:	00 
 440:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 444:	89 34 24             	mov    %esi,(%esp)
 447:	88 45 d7             	mov    %al,-0x29(%ebp)
 44a:	e8 fb fe ff ff       	call   34a <write>
  while(--i >= 0)
 44f:	83 ff ff             	cmp    $0xffffffff,%edi
 452:	75 dc                	jne    430 <printint+0x60>
    putc(fd, buf[i]);
}
 454:	83 c4 4c             	add    $0x4c,%esp
 457:	5b                   	pop    %ebx
 458:	5e                   	pop    %esi
 459:	5f                   	pop    %edi
 45a:	5d                   	pop    %ebp
 45b:	c3                   	ret    
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 460:	89 d0                	mov    %edx,%eax
 462:	f7 d8                	neg    %eax
    neg = 1;
 464:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 46b:	eb 87                	jmp    3f4 <printint+0x24>
 46d:	8d 76 00             	lea    0x0(%esi),%esi

00000470 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 474:	31 ff                	xor    %edi,%edi
{
 476:	56                   	push   %esi
 477:	53                   	push   %ebx
 478:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 47b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 47e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 481:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 484:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 487:	0f b6 13             	movzbl (%ebx),%edx
 48a:	83 c3 01             	add    $0x1,%ebx
 48d:	84 d2                	test   %dl,%dl
 48f:	75 39                	jne    4ca <printf+0x5a>
 491:	e9 c2 00 00 00       	jmp    558 <printf+0xe8>
 496:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 498:	83 fa 25             	cmp    $0x25,%edx
 49b:	0f 84 bf 00 00 00    	je     560 <printf+0xf0>
  write(fd, &c, 1);
 4a1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ab:	00 
 4ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 4b3:	88 55 e2             	mov    %dl,-0x1e(%ebp)
  write(fd, &c, 1);
 4b6:	e8 8f fe ff ff       	call   34a <write>
 4bb:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 4be:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4c2:	84 d2                	test   %dl,%dl
 4c4:	0f 84 8e 00 00 00    	je     558 <printf+0xe8>
    if(state == 0){
 4ca:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 4cc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 4cf:	74 c7                	je     498 <printf+0x28>
      }
    } else if(state == '%'){
 4d1:	83 ff 25             	cmp    $0x25,%edi
 4d4:	75 e5                	jne    4bb <printf+0x4b>
      if(c == 'd'){
 4d6:	83 fa 64             	cmp    $0x64,%edx
 4d9:	0f 84 31 01 00 00    	je     610 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4df:	25 f7 00 00 00       	and    $0xf7,%eax
 4e4:	83 f8 70             	cmp    $0x70,%eax
 4e7:	0f 84 83 00 00 00    	je     570 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4ed:	83 fa 73             	cmp    $0x73,%edx
 4f0:	0f 84 a2 00 00 00    	je     598 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4f6:	83 fa 63             	cmp    $0x63,%edx
 4f9:	0f 84 35 01 00 00    	je     634 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4ff:	83 fa 25             	cmp    $0x25,%edx
 502:	0f 84 e0 00 00 00    	je     5e8 <printf+0x178>
  write(fd, &c, 1);
 508:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 50b:	83 c3 01             	add    $0x1,%ebx
 50e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 515:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 516:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 518:	89 44 24 04          	mov    %eax,0x4(%esp)
 51c:	89 34 24             	mov    %esi,(%esp)
 51f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 522:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 526:	e8 1f fe ff ff       	call   34a <write>
        putc(fd, c);
 52b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 52e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 531:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 538:	00 
 539:	89 44 24 04          	mov    %eax,0x4(%esp)
 53d:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 540:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 543:	e8 02 fe ff ff       	call   34a <write>
  for(i = 0; fmt[i]; i++){
 548:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 54c:	84 d2                	test   %dl,%dl
 54e:	0f 85 76 ff ff ff    	jne    4ca <printf+0x5a>
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
}
 558:	83 c4 3c             	add    $0x3c,%esp
 55b:	5b                   	pop    %ebx
 55c:	5e                   	pop    %esi
 55d:	5f                   	pop    %edi
 55e:	5d                   	pop    %ebp
 55f:	c3                   	ret    
        state = '%';
 560:	bf 25 00 00 00       	mov    $0x25,%edi
 565:	e9 51 ff ff ff       	jmp    4bb <printf+0x4b>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 570:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 573:	b9 10 00 00 00       	mov    $0x10,%ecx
      state = 0;
 578:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 57a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 581:	8b 10                	mov    (%eax),%edx
 583:	89 f0                	mov    %esi,%eax
 585:	e8 46 fe ff ff       	call   3d0 <printint>
        ap++;
 58a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 58e:	e9 28 ff ff ff       	jmp    4bb <printf+0x4b>
 593:	90                   	nop
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 598:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 59b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 59f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 5a1:	b8 48 08 00 00       	mov    $0x848,%eax
 5a6:	85 ff                	test   %edi,%edi
 5a8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 5ab:	0f b6 07             	movzbl (%edi),%eax
 5ae:	84 c0                	test   %al,%al
 5b0:	74 2a                	je     5dc <printf+0x16c>
 5b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5b8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5bb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 5be:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 5c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5c8:	00 
 5c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cd:	89 34 24             	mov    %esi,(%esp)
 5d0:	e8 75 fd ff ff       	call   34a <write>
        while(*s != 0){
 5d5:	0f b6 07             	movzbl (%edi),%eax
 5d8:	84 c0                	test   %al,%al
 5da:	75 dc                	jne    5b8 <printf+0x148>
      state = 0;
 5dc:	31 ff                	xor    %edi,%edi
 5de:	e9 d8 fe ff ff       	jmp    4bb <printf+0x4b>
 5e3:	90                   	nop
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5e8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 5eb:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5ed:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5f4:	00 
 5f5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f9:	89 34 24             	mov    %esi,(%esp)
 5fc:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 600:	e8 45 fd ff ff       	call   34a <write>
 605:	e9 b1 fe ff ff       	jmp    4bb <printf+0x4b>
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 610:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 613:	b9 0a 00 00 00       	mov    $0xa,%ecx
      state = 0;
 618:	66 31 ff             	xor    %di,%di
        printint(fd, *ap, 10, 1);
 61b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 622:	8b 10                	mov    (%eax),%edx
 624:	89 f0                	mov    %esi,%eax
 626:	e8 a5 fd ff ff       	call   3d0 <printint>
        ap++;
 62b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 62f:	e9 87 fe ff ff       	jmp    4bb <printf+0x4b>
        putc(fd, *ap);
 634:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 637:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 639:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 63b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 642:	00 
 643:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 646:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 649:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 64c:	89 44 24 04          	mov    %eax,0x4(%esp)
 650:	e8 f5 fc ff ff       	call   34a <write>
        ap++;
 655:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 659:	e9 5d fe ff ff       	jmp    4bb <printf+0x4b>
 65e:	66 90                	xchg   %ax,%ax

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	a1 e0 0a 00 00       	mov    0xae0,%eax
{
 666:	89 e5                	mov    %esp,%ebp
 668:	57                   	push   %edi
 669:	56                   	push   %esi
 66a:	53                   	push   %ebx
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 670:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 673:	39 d0                	cmp    %edx,%eax
 675:	72 11                	jb     688 <free+0x28>
 677:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	39 c8                	cmp    %ecx,%eax
 67a:	72 04                	jb     680 <free+0x20>
 67c:	39 ca                	cmp    %ecx,%edx
 67e:	72 10                	jb     690 <free+0x30>
 680:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 682:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 684:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 686:	73 f0                	jae    678 <free+0x18>
 688:	39 ca                	cmp    %ecx,%edx
 68a:	72 04                	jb     690 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 68c:	39 c8                	cmp    %ecx,%eax
 68e:	72 f0                	jb     680 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 690:	8b 73 fc             	mov    -0x4(%ebx),%esi
 693:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 696:	39 cf                	cmp    %ecx,%edi
 698:	74 1e                	je     6b8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 69a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 69d:	8b 48 04             	mov    0x4(%eax),%ecx
 6a0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6a3:	39 f2                	cmp    %esi,%edx
 6a5:	74 28                	je     6cf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6a7:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a9:	a3 e0 0a 00 00       	mov    %eax,0xae0
}
 6ae:	5b                   	pop    %ebx
 6af:	5e                   	pop    %esi
 6b0:	5f                   	pop    %edi
 6b1:	5d                   	pop    %ebp
 6b2:	c3                   	ret    
 6b3:	90                   	nop
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6b8:	03 71 04             	add    0x4(%ecx),%esi
 6bb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6be:	8b 08                	mov    (%eax),%ecx
 6c0:	8b 09                	mov    (%ecx),%ecx
 6c2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6c5:	8b 48 04             	mov    0x4(%eax),%ecx
 6c8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6cb:	39 f2                	cmp    %esi,%edx
 6cd:	75 d8                	jne    6a7 <free+0x47>
    p->s.size += bp->s.size;
 6cf:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 6d2:	a3 e0 0a 00 00       	mov    %eax,0xae0
    p->s.size += bp->s.size;
 6d7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6da:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6dd:	89 10                	mov    %edx,(%eax)
}
 6df:	5b                   	pop    %ebx
 6e0:	5e                   	pop    %esi
 6e1:	5f                   	pop    %edi
 6e2:	5d                   	pop    %ebp
 6e3:	c3                   	ret    
 6e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6fc:	8b 1d e0 0a 00 00    	mov    0xae0,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 702:	8d 48 07             	lea    0x7(%eax),%ecx
 705:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 708:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 70d:	0f 84 9b 00 00 00    	je     7ae <malloc+0xbe>
 713:	8b 13                	mov    (%ebx),%edx
 715:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 718:	39 fe                	cmp    %edi,%esi
 71a:	76 64                	jbe    780 <malloc+0x90>
 71c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 723:	bb 00 80 00 00       	mov    $0x8000,%ebx
 728:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 72b:	eb 0e                	jmp    73b <malloc+0x4b>
 72d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 730:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 732:	8b 78 04             	mov    0x4(%eax),%edi
 735:	39 fe                	cmp    %edi,%esi
 737:	76 4f                	jbe    788 <malloc+0x98>
 739:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 73b:	3b 15 e0 0a 00 00    	cmp    0xae0,%edx
 741:	75 ed                	jne    730 <malloc+0x40>
  if(nu < 4096)
 743:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 746:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 74c:	bf 00 10 00 00       	mov    $0x1000,%edi
 751:	0f 43 fe             	cmovae %esi,%edi
 754:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 757:	89 04 24             	mov    %eax,(%esp)
 75a:	e8 53 fc ff ff       	call   3b2 <sbrk>
  if(p == (char*)-1)
 75f:	83 f8 ff             	cmp    $0xffffffff,%eax
 762:	74 18                	je     77c <malloc+0x8c>
  hp->s.size = nu;
 764:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 767:	83 c0 08             	add    $0x8,%eax
 76a:	89 04 24             	mov    %eax,(%esp)
 76d:	e8 ee fe ff ff       	call   660 <free>
  return freep;
 772:	8b 15 e0 0a 00 00    	mov    0xae0,%edx
      if((p = morecore(nunits)) == 0)
 778:	85 d2                	test   %edx,%edx
 77a:	75 b4                	jne    730 <malloc+0x40>
        return 0;
 77c:	31 c0                	xor    %eax,%eax
 77e:	eb 20                	jmp    7a0 <malloc+0xb0>
    if(p->s.size >= nunits){
 780:	89 d0                	mov    %edx,%eax
 782:	89 da                	mov    %ebx,%edx
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 788:	39 fe                	cmp    %edi,%esi
 78a:	74 1c                	je     7a8 <malloc+0xb8>
        p->s.size -= nunits;
 78c:	29 f7                	sub    %esi,%edi
 78e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 791:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 794:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 797:	89 15 e0 0a 00 00    	mov    %edx,0xae0
      return (void*)(p + 1);
 79d:	83 c0 08             	add    $0x8,%eax
  }
}
 7a0:	83 c4 1c             	add    $0x1c,%esp
 7a3:	5b                   	pop    %ebx
 7a4:	5e                   	pop    %esi
 7a5:	5f                   	pop    %edi
 7a6:	5d                   	pop    %ebp
 7a7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 7a8:	8b 08                	mov    (%eax),%ecx
 7aa:	89 0a                	mov    %ecx,(%edx)
 7ac:	eb e9                	jmp    797 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 7ae:	c7 05 e0 0a 00 00 e4 	movl   $0xae4,0xae0
 7b5:	0a 00 00 
    base.s.size = 0;
 7b8:	ba e4 0a 00 00       	mov    $0xae4,%edx
    base.s.ptr = freep = prevp = &base;
 7bd:	c7 05 e4 0a 00 00 e4 	movl   $0xae4,0xae4
 7c4:	0a 00 00 
    base.s.size = 0;
 7c7:	c7 05 e8 0a 00 00 00 	movl   $0x0,0xae8
 7ce:	00 00 00 
 7d1:	e9 46 ff ff ff       	jmp    71c <malloc+0x2c>
