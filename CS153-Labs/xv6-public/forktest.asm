
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  forktest();
   9:	e8 42 00 00 00       	call   50 <forktest>
  exit(0);
   e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  15:	e8 68 03 00 00       	call   382 <exit>
  1a:	66 90                	xchg   %ax,%ax
  1c:	66 90                	xchg   %ax,%ax
  1e:	66 90                	xchg   %ax,%ax

00000020 <printf>:
{
  20:	55                   	push   %ebp
  21:	89 e5                	mov    %esp,%ebp
  23:	53                   	push   %ebx
  24:	83 ec 14             	sub    $0x14,%esp
  27:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  2a:	89 1c 24             	mov    %ebx,(%esp)
  2d:	e8 ae 01 00 00       	call   1e0 <strlen>
  32:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  36:	89 44 24 08          	mov    %eax,0x8(%esp)
  3a:	8b 45 08             	mov    0x8(%ebp),%eax
  3d:	89 04 24             	mov    %eax,(%esp)
  40:	e8 65 03 00 00       	call   3aa <write>
}
  45:	83 c4 14             	add    $0x14,%esp
  48:	5b                   	pop    %ebx
  49:	5d                   	pop    %ebp
  4a:	c3                   	ret    
  4b:	90                   	nop
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000050 <forktest>:
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	53                   	push   %ebx
  for(n=0; n<N; n++){
  54:	31 db                	xor    %ebx,%ebx
{
  56:	83 ec 14             	sub    $0x14,%esp
  printf(1, "fork test\n");
  59:	c7 44 24 04 2c 04 00 	movl   $0x42c,0x4(%esp)
  60:	00 
  61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  68:	e8 b3 ff ff ff       	call   20 <printf>
  6d:	eb 13                	jmp    82 <forktest+0x32>
  6f:	90                   	nop
    if(pid == 0)
  70:	0f 84 92 00 00 00    	je     108 <forktest+0xb8>
  for(n=0; n<N; n++){
  76:	83 c3 01             	add    $0x1,%ebx
  79:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  7f:	90                   	nop
  80:	74 56                	je     d8 <forktest+0x88>
    pid = fork();
  82:	e8 f3 02 00 00       	call   37a <fork>
    if(pid < 0)
  87:	85 c0                	test   %eax,%eax
  89:	79 e5                	jns    70 <forktest+0x20>
  for(; n > 0; n--){
  8b:	85 db                	test   %ebx,%ebx
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	74 1b                	je     ad <forktest+0x5d>
  92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait(0) < 0){
  98:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  9f:	e8 e6 02 00 00       	call   38a <wait>
  a4:	85 c0                	test   %eax,%eax
  a6:	78 6c                	js     114 <forktest+0xc4>
  for(; n > 0; n--){
  a8:	83 eb 01             	sub    $0x1,%ebx
  ab:	75 eb                	jne    98 <forktest+0x48>
  if(wait(0) != -1){
  ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  b4:	e8 d1 02 00 00       	call   38a <wait>
  b9:	83 f8 ff             	cmp    $0xffffffff,%eax
  bc:	75 76                	jne    134 <forktest+0xe4>
  printf(1, "fork test OK\n");
  be:	c7 44 24 04 5e 04 00 	movl   $0x45e,0x4(%esp)
  c5:	00 
  c6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cd:	e8 4e ff ff ff       	call   20 <printf>
}
  d2:	83 c4 14             	add    $0x14,%esp
  d5:	5b                   	pop    %ebx
  d6:	5d                   	pop    %ebp
  d7:	c3                   	ret    
  write(fd, s, strlen(s));
  d8:	c7 04 24 6c 04 00 00 	movl   $0x46c,(%esp)
  df:	e8 fc 00 00 00       	call   1e0 <strlen>
  e4:	c7 44 24 04 6c 04 00 	movl   $0x46c,0x4(%esp)
  eb:	00 
  ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f3:	89 44 24 08          	mov    %eax,0x8(%esp)
  f7:	e8 ae 02 00 00       	call   3aa <write>
    exit(1);
  fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 103:	e8 7a 02 00 00       	call   382 <exit>
      exit(0);
 108:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 10f:	e8 6e 02 00 00       	call   382 <exit>
      printf(1, "wait stopped early\n");
 114:	c7 44 24 04 37 04 00 	movl   $0x437,0x4(%esp)
 11b:	00 
 11c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 123:	e8 f8 fe ff ff       	call   20 <printf>
      exit(1);
 128:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 12f:	e8 4e 02 00 00       	call   382 <exit>
    printf(1, "wait got too many\n");
 134:	c7 44 24 04 4b 04 00 	movl   $0x44b,0x4(%esp)
 13b:	00 
 13c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 143:	e8 d8 fe ff ff       	call   20 <printf>
    exit(1);
 148:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 14f:	e8 2e 02 00 00       	call   382 <exit>
 154:	66 90                	xchg   %ax,%ax
 156:	66 90                	xchg   %ax,%ax
 158:	66 90                	xchg   %ax,%ax
 15a:	66 90                	xchg   %ax,%ax
 15c:	66 90                	xchg   %ax,%ax
 15e:	66 90                	xchg   %ax,%ax

00000160 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 169:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 16a:	89 c2                	mov    %eax,%edx
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 170:	83 c1 01             	add    $0x1,%ecx
 173:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 177:	83 c2 01             	add    $0x1,%edx
 17a:	84 db                	test   %bl,%bl
 17c:	88 5a ff             	mov    %bl,-0x1(%edx)
 17f:	75 ef                	jne    170 <strcpy+0x10>
    ;
  return os;
}
 181:	5b                   	pop    %ebx
 182:	5d                   	pop    %ebp
 183:	c3                   	ret    
 184:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 18a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000190 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 55 08             	mov    0x8(%ebp),%edx
 196:	53                   	push   %ebx
 197:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 19a:	0f b6 02             	movzbl (%edx),%eax
 19d:	84 c0                	test   %al,%al
 19f:	74 2d                	je     1ce <strcmp+0x3e>
 1a1:	0f b6 19             	movzbl (%ecx),%ebx
 1a4:	38 d8                	cmp    %bl,%al
 1a6:	74 0e                	je     1b6 <strcmp+0x26>
 1a8:	eb 2b                	jmp    1d5 <strcmp+0x45>
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1b0:	38 c8                	cmp    %cl,%al
 1b2:	75 15                	jne    1c9 <strcmp+0x39>
    p++, q++;
 1b4:	89 d9                	mov    %ebx,%ecx
 1b6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1b9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1bc:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1bf:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 1c3:	84 c0                	test   %al,%al
 1c5:	75 e9                	jne    1b0 <strcmp+0x20>
 1c7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1c9:	29 c8                	sub    %ecx,%eax
}
 1cb:	5b                   	pop    %ebx
 1cc:	5d                   	pop    %ebp
 1cd:	c3                   	ret    
 1ce:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 1d1:	31 c0                	xor    %eax,%eax
 1d3:	eb f4                	jmp    1c9 <strcmp+0x39>
 1d5:	0f b6 cb             	movzbl %bl,%ecx
 1d8:	eb ef                	jmp    1c9 <strcmp+0x39>
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001e0 <strlen>:

uint
strlen(const char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1e6:	80 39 00             	cmpb   $0x0,(%ecx)
 1e9:	74 12                	je     1fd <strlen+0x1d>
 1eb:	31 d2                	xor    %edx,%edx
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	83 c2 01             	add    $0x1,%edx
 1f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1f7:	89 d0                	mov    %edx,%eax
 1f9:	75 f5                	jne    1f0 <strlen+0x10>
    ;
  return n;
}
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
  for(n = 0; s[n]; n++)
 1fd:	31 c0                	xor    %eax,%eax
}
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret    
 201:	eb 0d                	jmp    210 <memset>
 203:	90                   	nop
 204:	90                   	nop
 205:	90                   	nop
 206:	90                   	nop
 207:	90                   	nop
 208:	90                   	nop
 209:	90                   	nop
 20a:	90                   	nop
 20b:	90                   	nop
 20c:	90                   	nop
 20d:	90                   	nop
 20e:	90                   	nop
 20f:	90                   	nop

00000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
 216:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 217:	8b 4d 10             	mov    0x10(%ebp),%ecx
 21a:	8b 45 0c             	mov    0xc(%ebp),%eax
 21d:	89 d7                	mov    %edx,%edi
 21f:	fc                   	cld    
 220:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 222:	89 d0                	mov    %edx,%eax
 224:	5f                   	pop    %edi
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <strchr>:

char*
strchr(const char *s, char c)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	53                   	push   %ebx
 237:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 23a:	0f b6 18             	movzbl (%eax),%ebx
 23d:	84 db                	test   %bl,%bl
 23f:	74 1d                	je     25e <strchr+0x2e>
    if(*s == c)
 241:	38 d3                	cmp    %dl,%bl
 243:	89 d1                	mov    %edx,%ecx
 245:	75 0d                	jne    254 <strchr+0x24>
 247:	eb 17                	jmp    260 <strchr+0x30>
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 250:	38 ca                	cmp    %cl,%dl
 252:	74 0c                	je     260 <strchr+0x30>
  for(; *s; s++)
 254:	83 c0 01             	add    $0x1,%eax
 257:	0f b6 10             	movzbl (%eax),%edx
 25a:	84 d2                	test   %dl,%dl
 25c:	75 f2                	jne    250 <strchr+0x20>
      return (char*)s;
  return 0;
 25e:	31 c0                	xor    %eax,%eax
}
 260:	5b                   	pop    %ebx
 261:	5d                   	pop    %ebp
 262:	c3                   	ret    
 263:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <gets>:

char*
gets(char *buf, int max)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 275:	31 f6                	xor    %esi,%esi
{
 277:	53                   	push   %ebx
 278:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 27b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 27e:	eb 31                	jmp    2b1 <gets+0x41>
    cc = read(0, &c, 1);
 280:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 287:	00 
 288:	89 7c 24 04          	mov    %edi,0x4(%esp)
 28c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 293:	e8 0a 01 00 00       	call   3a2 <read>
    if(cc < 1)
 298:	85 c0                	test   %eax,%eax
 29a:	7e 1d                	jle    2b9 <gets+0x49>
      break;
    buf[i++] = c;
 29c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 2a0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 2a2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 2a5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 2a7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2ab:	74 0c                	je     2b9 <gets+0x49>
 2ad:	3c 0a                	cmp    $0xa,%al
 2af:	74 08                	je     2b9 <gets+0x49>
  for(i=0; i+1 < max; ){
 2b1:	8d 5e 01             	lea    0x1(%esi),%ebx
 2b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2b7:	7c c7                	jl     280 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2c0:	83 c4 2c             	add    $0x2c,%esp
 2c3:	5b                   	pop    %ebx
 2c4:	5e                   	pop    %esi
 2c5:	5f                   	pop    %edi
 2c6:	5d                   	pop    %ebp
 2c7:	c3                   	ret    
 2c8:	90                   	nop
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
 2d5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d8:	8b 45 08             	mov    0x8(%ebp),%eax
 2db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2e2:	00 
 2e3:	89 04 24             	mov    %eax,(%esp)
 2e6:	e8 df 00 00 00       	call   3ca <open>
  if(fd < 0)
 2eb:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 2ed:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2ef:	78 27                	js     318 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2f1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2f4:	89 1c 24             	mov    %ebx,(%esp)
 2f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 2fb:	e8 e2 00 00 00       	call   3e2 <fstat>
  close(fd);
 300:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 303:	89 c6                	mov    %eax,%esi
  close(fd);
 305:	e8 a8 00 00 00       	call   3b2 <close>
  return r;
 30a:	89 f0                	mov    %esi,%eax
}
 30c:	83 c4 10             	add    $0x10,%esp
 30f:	5b                   	pop    %ebx
 310:	5e                   	pop    %esi
 311:	5d                   	pop    %ebp
 312:	c3                   	ret    
 313:	90                   	nop
 314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 31d:	eb ed                	jmp    30c <stat+0x3c>
 31f:	90                   	nop

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	8b 4d 08             	mov    0x8(%ebp),%ecx
 326:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 11             	movsbl (%ecx),%edx
 32a:	8d 42 d0             	lea    -0x30(%edx),%eax
 32d:	3c 09                	cmp    $0x9,%al
  n = 0;
 32f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 334:	77 17                	ja     34d <atoi+0x2d>
 336:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 338:	83 c1 01             	add    $0x1,%ecx
 33b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 33e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 342:	0f be 11             	movsbl (%ecx),%edx
 345:	8d 5a d0             	lea    -0x30(%edx),%ebx
 348:	80 fb 09             	cmp    $0x9,%bl
 34b:	76 eb                	jbe    338 <atoi+0x18>
  return n;
}
 34d:	5b                   	pop    %ebx
 34e:	5d                   	pop    %ebp
 34f:	c3                   	ret    

00000350 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 350:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 351:	31 d2                	xor    %edx,%edx
{
 353:	89 e5                	mov    %esp,%ebp
 355:	56                   	push   %esi
 356:	8b 45 08             	mov    0x8(%ebp),%eax
 359:	53                   	push   %ebx
 35a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 35d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 360:	85 db                	test   %ebx,%ebx
 362:	7e 12                	jle    376 <memmove+0x26>
 364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 368:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 36c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 36f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 372:	39 da                	cmp    %ebx,%edx
 374:	75 f2                	jne    368 <memmove+0x18>
  return vdst;
}
 376:	5b                   	pop    %ebx
 377:	5e                   	pop    %esi
 378:	5d                   	pop    %ebp
 379:	c3                   	ret    

0000037a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 37a:	b8 01 00 00 00       	mov    $0x1,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <exit>:
SYSCALL(exit)
 382:	b8 02 00 00 00       	mov    $0x2,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <wait>:
SYSCALL(wait)
 38a:	b8 03 00 00 00       	mov    $0x3,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <waitpid>:
SYSCALL(waitpid)
 392:	b8 16 00 00 00       	mov    $0x16,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <pipe>:
SYSCALL(pipe)
 39a:	b8 04 00 00 00       	mov    $0x4,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <read>:
SYSCALL(read)
 3a2:	b8 05 00 00 00       	mov    $0x5,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <write>:
SYSCALL(write)
 3aa:	b8 10 00 00 00       	mov    $0x10,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <close>:
SYSCALL(close)
 3b2:	b8 15 00 00 00       	mov    $0x15,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <kill>:
SYSCALL(kill)
 3ba:	b8 06 00 00 00       	mov    $0x6,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <exec>:
SYSCALL(exec)
 3c2:	b8 07 00 00 00       	mov    $0x7,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <open>:
SYSCALL(open)
 3ca:	b8 0f 00 00 00       	mov    $0xf,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <mknod>:
SYSCALL(mknod)
 3d2:	b8 11 00 00 00       	mov    $0x11,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <unlink>:
SYSCALL(unlink)
 3da:	b8 12 00 00 00       	mov    $0x12,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <fstat>:
SYSCALL(fstat)
 3e2:	b8 08 00 00 00       	mov    $0x8,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <link>:
SYSCALL(link)
 3ea:	b8 13 00 00 00       	mov    $0x13,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <mkdir>:
SYSCALL(mkdir)
 3f2:	b8 14 00 00 00       	mov    $0x14,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <chdir>:
SYSCALL(chdir)
 3fa:	b8 09 00 00 00       	mov    $0x9,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <dup>:
SYSCALL(dup)
 402:	b8 0a 00 00 00       	mov    $0xa,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <getpid>:
SYSCALL(getpid)
 40a:	b8 0b 00 00 00       	mov    $0xb,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <sbrk>:
SYSCALL(sbrk)
 412:	b8 0c 00 00 00       	mov    $0xc,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <sleep>:
SYSCALL(sleep)
 41a:	b8 0d 00 00 00       	mov    $0xd,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <uptime>:
SYSCALL(uptime)
 422:	b8 0e 00 00 00       	mov    $0xe,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    
