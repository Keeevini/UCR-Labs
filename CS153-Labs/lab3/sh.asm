
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0e                	jmp    19 <main+0x19>
       b:	90                   	nop
       c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	0f 8f db 00 00 00    	jg     f4 <main+0xf4>
  while((fd = open("console", O_RDWR)) >= 0){
      19:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
      20:	00 
      21:	c7 04 24 69 13 00 00 	movl   $0x1369,(%esp)
      28:	e8 2d 0e 00 00       	call   e5a <open>
      2d:	85 c0                	test   %eax,%eax
      2f:	79 df                	jns    10 <main+0x10>
      31:	eb 2a                	jmp    5d <main+0x5d>
      33:	90                   	nop
      34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d 62 19 00 00 20 	cmpb   $0x20,0x1962
      3f:	90                   	nop
      40:	74 6e                	je     b0 <main+0xb0>
      42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      48:	e8 53 01 00 00       	call   1a0 <fork1>
      4d:	85 c0                	test   %eax,%eax
      4f:	74 3f                	je     90 <main+0x90>
      runcmd(parsecmd(buf));
    wait(0);
      51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      58:	e8 bd 0d 00 00       	call   e1a <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      5d:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
      64:	00 
      65:	c7 04 24 60 19 00 00 	movl   $0x1960,(%esp)
      6c:	e8 9f 00 00 00       	call   110 <getcmd>
      71:	85 c0                	test   %eax,%eax
      73:	78 2f                	js     a4 <main+0xa4>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      75:	80 3d 60 19 00 00 63 	cmpb   $0x63,0x1960
      7c:	75 ca                	jne    48 <main+0x48>
      7e:	80 3d 61 19 00 00 64 	cmpb   $0x64,0x1961
      85:	74 b1                	je     38 <main+0x38>
    if(fork1() == 0)
      87:	e8 14 01 00 00       	call   1a0 <fork1>
      8c:	85 c0                	test   %eax,%eax
      8e:	75 c1                	jne    51 <main+0x51>
      runcmd(parsecmd(buf));
      90:	c7 04 24 60 19 00 00 	movl   $0x1960,(%esp)
      97:	e8 d4 0a 00 00       	call   b70 <parsecmd>
      9c:	89 04 24             	mov    %eax,(%esp)
      9f:	e8 1c 01 00 00       	call   1c0 <runcmd>
  }
  exit(0);
      a4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      ab:	e8 62 0d 00 00       	call   e12 <exit>
      buf[strlen(buf)-1] = 0;  // chop \n
      b0:	c7 04 24 60 19 00 00 	movl   $0x1960,(%esp)
      b7:	e8 b4 0b 00 00       	call   c70 <strlen>
      if(chdir(buf+3) < 0)
      bc:	c7 04 24 63 19 00 00 	movl   $0x1963,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      c3:	c6 80 5f 19 00 00 00 	movb   $0x0,0x195f(%eax)
      if(chdir(buf+3) < 0)
      ca:	e8 bb 0d 00 00       	call   e8a <chdir>
      cf:	85 c0                	test   %eax,%eax
      d1:	79 8a                	jns    5d <main+0x5d>
        printf(2, "cannot cd %s\n", buf+3);
      d3:	c7 44 24 08 63 19 00 	movl   $0x1963,0x8(%esp)
      da:	00 
      db:	c7 44 24 04 71 13 00 	movl   $0x1371,0x4(%esp)
      e2:	00 
      e3:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      ea:	e8 71 0e 00 00       	call   f60 <printf>
      ef:	e9 69 ff ff ff       	jmp    5d <main+0x5d>
      close(fd);
      f4:	89 04 24             	mov    %eax,(%esp)
      f7:	e8 46 0d 00 00       	call   e42 <close>
      fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
     100:	e9 58 ff ff ff       	jmp    5d <main+0x5d>
     105:	66 90                	xchg   %ax,%ax
     107:	66 90                	xchg   %ax,%ax
     109:	66 90                	xchg   %ax,%ax
     10b:	66 90                	xchg   %ax,%ax
     10d:	66 90                	xchg   %ax,%ax
     10f:	90                   	nop

00000110 <getcmd>:
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	56                   	push   %esi
     114:	53                   	push   %ebx
     115:	83 ec 10             	sub    $0x10,%esp
     118:	8b 5d 08             	mov    0x8(%ebp),%ebx
     11b:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     11e:	c7 44 24 04 c8 12 00 	movl   $0x12c8,0x4(%esp)
     125:	00 
     126:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     12d:	e8 2e 0e 00 00       	call   f60 <printf>
  memset(buf, 0, nbuf);
     132:	89 74 24 08          	mov    %esi,0x8(%esp)
     136:	89 1c 24             	mov    %ebx,(%esp)
     139:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     140:	00 
     141:	e8 5a 0b 00 00       	call   ca0 <memset>
  gets(buf, nbuf);
     146:	89 74 24 04          	mov    %esi,0x4(%esp)
     14a:	89 1c 24             	mov    %ebx,(%esp)
     14d:	e8 ae 0b 00 00       	call   d00 <gets>
  if(buf[0] == 0) // EOF
     152:	31 c0                	xor    %eax,%eax
     154:	80 3b 00             	cmpb   $0x0,(%ebx)
     157:	0f 94 c0             	sete   %al
}
     15a:	83 c4 10             	add    $0x10,%esp
     15d:	5b                   	pop    %ebx
  if(buf[0] == 0) // EOF
     15e:	f7 d8                	neg    %eax
}
     160:	5e                   	pop    %esi
     161:	5d                   	pop    %ebp
     162:	c3                   	ret    
     163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <panic>:
}

void
panic(char *s)
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     176:	8b 45 08             	mov    0x8(%ebp),%eax
     179:	c7 44 24 04 65 13 00 	movl   $0x1365,0x4(%esp)
     180:	00 
     181:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     188:	89 44 24 08          	mov    %eax,0x8(%esp)
     18c:	e8 cf 0d 00 00       	call   f60 <printf>
  exit(1);
     191:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     198:	e8 75 0c 00 00       	call   e12 <exit>
     19d:	8d 76 00             	lea    0x0(%esi),%esi

000001a0 <fork1>:
}

int
fork1(void)
{
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	83 ec 18             	sub    $0x18,%esp
  int pid;

  pid = fork();
     1a6:	e8 5f 0c 00 00       	call   e0a <fork>
  if(pid == -1)
     1ab:	83 f8 ff             	cmp    $0xffffffff,%eax
     1ae:	74 02                	je     1b2 <fork1+0x12>
    panic("fork");
  return pid;
}
     1b0:	c9                   	leave  
     1b1:	c3                   	ret    
    panic("fork");
     1b2:	c7 04 24 cb 12 00 00 	movl   $0x12cb,(%esp)
     1b9:	e8 b2 ff ff ff       	call   170 <panic>
     1be:	66 90                	xchg   %ax,%ax

000001c0 <runcmd>:
{
     1c0:	55                   	push   %ebp
     1c1:	89 e5                	mov    %esp,%ebp
     1c3:	53                   	push   %ebx
     1c4:	83 ec 24             	sub    $0x24,%esp
     1c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1ca:	85 db                	test   %ebx,%ebx
     1cc:	74 6d                	je     23b <runcmd+0x7b>
  switch(cmd->type){
     1ce:	83 3b 05             	cmpl   $0x5,(%ebx)
     1d1:	0f 87 fe 00 00 00    	ja     2d5 <runcmd+0x115>
     1d7:	8b 03                	mov    (%ebx),%eax
     1d9:	ff 24 85 80 13 00 00 	jmp    *0x1380(,%eax,4)
    if(pipe(p) < 0)
     1e0:	8d 45 f0             	lea    -0x10(%ebp),%eax
     1e3:	89 04 24             	mov    %eax,(%esp)
     1e6:	e8 3f 0c 00 00       	call   e2a <pipe>
     1eb:	85 c0                	test   %eax,%eax
     1ed:	0f 88 ee 00 00 00    	js     2e1 <runcmd+0x121>
    if(fork1() == 0){
     1f3:	e8 a8 ff ff ff       	call   1a0 <fork1>
     1f8:	85 c0                	test   %eax,%eax
     1fa:	0f 84 4c 01 00 00    	je     34c <runcmd+0x18c>
    if(fork1() == 0){
     200:	e8 9b ff ff ff       	call   1a0 <fork1>
     205:	85 c0                	test   %eax,%eax
     207:	0f 84 07 01 00 00    	je     314 <runcmd+0x154>
    close(p[0]);
     20d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     210:	89 04 24             	mov    %eax,(%esp)
     213:	e8 2a 0c 00 00       	call   e42 <close>
    close(p[1]);
     218:	8b 45 f4             	mov    -0xc(%ebp),%eax
     21b:	89 04 24             	mov    %eax,(%esp)
     21e:	e8 1f 0c 00 00       	call   e42 <close>
    wait(0);
     223:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     22a:	e8 eb 0b 00 00       	call   e1a <wait>
    wait(0);
     22f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     236:	e8 df 0b 00 00       	call   e1a <wait>
    exit(0);
     23b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     242:	e8 cb 0b 00 00       	call   e12 <exit>
    if(fork1() == 0)
     247:	e8 54 ff ff ff       	call   1a0 <fork1>
     24c:	85 c0                	test   %eax,%eax
     24e:	75 eb                	jne    23b <runcmd+0x7b>
     250:	eb 78                	jmp    2ca <runcmd+0x10a>
    if(ecmd->argv[0] == 0)
     252:	8b 43 04             	mov    0x4(%ebx),%eax
     255:	85 c0                	test   %eax,%eax
     257:	74 e2                	je     23b <runcmd+0x7b>
    exec(ecmd->argv[0], ecmd->argv);
     259:	8d 53 04             	lea    0x4(%ebx),%edx
     25c:	89 54 24 04          	mov    %edx,0x4(%esp)
     260:	89 04 24             	mov    %eax,(%esp)
     263:	e8 ea 0b 00 00       	call   e52 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     268:	8b 43 04             	mov    0x4(%ebx),%eax
     26b:	c7 44 24 04 d7 12 00 	movl   $0x12d7,0x4(%esp)
     272:	00 
     273:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     27a:	89 44 24 08          	mov    %eax,0x8(%esp)
     27e:	e8 dd 0c 00 00       	call   f60 <printf>
    break;
     283:	eb b6                	jmp    23b <runcmd+0x7b>
    if(fork1() == 0)
     285:	e8 16 ff ff ff       	call   1a0 <fork1>
     28a:	85 c0                	test   %eax,%eax
     28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     290:	74 38                	je     2ca <runcmd+0x10a>
    wait(0);
     292:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     299:	e8 7c 0b 00 00       	call   e1a <wait>
    runcmd(lcmd->right);
     29e:	8b 43 08             	mov    0x8(%ebx),%eax
     2a1:	89 04 24             	mov    %eax,(%esp)
     2a4:	e8 17 ff ff ff       	call   1c0 <runcmd>
    close(rcmd->fd);
     2a9:	8b 43 14             	mov    0x14(%ebx),%eax
     2ac:	89 04 24             	mov    %eax,(%esp)
     2af:	e8 8e 0b 00 00       	call   e42 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     2b4:	8b 43 10             	mov    0x10(%ebx),%eax
     2b7:	89 44 24 04          	mov    %eax,0x4(%esp)
     2bb:	8b 43 08             	mov    0x8(%ebx),%eax
     2be:	89 04 24             	mov    %eax,(%esp)
     2c1:	e8 94 0b 00 00       	call   e5a <open>
     2c6:	85 c0                	test   %eax,%eax
     2c8:	78 23                	js     2ed <runcmd+0x12d>
      runcmd(bcmd->cmd);
     2ca:	8b 43 04             	mov    0x4(%ebx),%eax
     2cd:	89 04 24             	mov    %eax,(%esp)
     2d0:	e8 eb fe ff ff       	call   1c0 <runcmd>
    panic("runcmd");
     2d5:	c7 04 24 d0 12 00 00 	movl   $0x12d0,(%esp)
     2dc:	e8 8f fe ff ff       	call   170 <panic>
      panic("pipe");
     2e1:	c7 04 24 f7 12 00 00 	movl   $0x12f7,(%esp)
     2e8:	e8 83 fe ff ff       	call   170 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     2ed:	8b 43 08             	mov    0x8(%ebx),%eax
     2f0:	c7 44 24 04 e7 12 00 	movl   $0x12e7,0x4(%esp)
     2f7:	00 
     2f8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     2ff:	89 44 24 08          	mov    %eax,0x8(%esp)
     303:	e8 58 0c 00 00       	call   f60 <printf>
      exit(1);
     308:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     30f:	e8 fe 0a 00 00       	call   e12 <exit>
      close(0);
     314:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     31b:	e8 22 0b 00 00       	call   e42 <close>
      dup(p[0]);
     320:	8b 45 f0             	mov    -0x10(%ebp),%eax
     323:	89 04 24             	mov    %eax,(%esp)
     326:	e8 67 0b 00 00       	call   e92 <dup>
      close(p[0]);
     32b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     32e:	89 04 24             	mov    %eax,(%esp)
     331:	e8 0c 0b 00 00       	call   e42 <close>
      close(p[1]);
     336:	8b 45 f4             	mov    -0xc(%ebp),%eax
     339:	89 04 24             	mov    %eax,(%esp)
     33c:	e8 01 0b 00 00       	call   e42 <close>
      runcmd(pcmd->right);
     341:	8b 43 08             	mov    0x8(%ebx),%eax
     344:	89 04 24             	mov    %eax,(%esp)
     347:	e8 74 fe ff ff       	call   1c0 <runcmd>
      close(1);
     34c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     353:	e8 ea 0a 00 00       	call   e42 <close>
      dup(p[1]);
     358:	8b 45 f4             	mov    -0xc(%ebp),%eax
     35b:	89 04 24             	mov    %eax,(%esp)
     35e:	e8 2f 0b 00 00       	call   e92 <dup>
      close(p[0]);
     363:	8b 45 f0             	mov    -0x10(%ebp),%eax
     366:	89 04 24             	mov    %eax,(%esp)
     369:	e8 d4 0a 00 00       	call   e42 <close>
      close(p[1]);
     36e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     371:	89 04 24             	mov    %eax,(%esp)
     374:	e8 c9 0a 00 00       	call   e42 <close>
      runcmd(pcmd->left);
     379:	8b 43 04             	mov    0x4(%ebx),%eax
     37c:	89 04 24             	mov    %eax,(%esp)
     37f:	e8 3c fe ff ff       	call   1c0 <runcmd>
     384:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     38a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000390 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     390:	55                   	push   %ebp
     391:	89 e5                	mov    %esp,%ebp
     393:	53                   	push   %ebx
     394:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     397:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     39e:	e8 3d 0e 00 00       	call   11e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3a3:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     3aa:	00 
     3ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3b2:	00 
  cmd = malloc(sizeof(*cmd));
     3b3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3b5:	89 04 24             	mov    %eax,(%esp)
     3b8:	e8 e3 08 00 00       	call   ca0 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     3bd:	89 d8                	mov    %ebx,%eax
  cmd->type = EXEC;
     3bf:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     3c5:	83 c4 14             	add    $0x14,%esp
     3c8:	5b                   	pop    %ebx
     3c9:	5d                   	pop    %ebp
     3ca:	c3                   	ret    
     3cb:	90                   	nop
     3cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003d0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	53                   	push   %ebx
     3d4:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d7:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     3de:	e8 fd 0d 00 00       	call   11e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3e3:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     3ea:	00 
     3eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3f2:	00 
     3f3:	89 04 24             	mov    %eax,(%esp)
  cmd = malloc(sizeof(*cmd));
     3f6:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3f8:	e8 a3 08 00 00       	call   ca0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     3fd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     400:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     406:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     409:	8b 45 0c             	mov    0xc(%ebp),%eax
     40c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     40f:	8b 45 10             	mov    0x10(%ebp),%eax
     412:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     415:	8b 45 14             	mov    0x14(%ebp),%eax
     418:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     41b:	8b 45 18             	mov    0x18(%ebp),%eax
     41e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     421:	83 c4 14             	add    $0x14,%esp
     424:	89 d8                	mov    %ebx,%eax
     426:	5b                   	pop    %ebx
     427:	5d                   	pop    %ebp
     428:	c3                   	ret    
     429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000430 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	53                   	push   %ebx
     434:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     437:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     43e:	e8 9d 0d 00 00       	call   11e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     443:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     44a:	00 
     44b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     452:	00 
     453:	89 04 24             	mov    %eax,(%esp)
  cmd = malloc(sizeof(*cmd));
     456:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     458:	e8 43 08 00 00       	call   ca0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     45d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     460:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     466:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     469:	8b 45 0c             	mov    0xc(%ebp),%eax
     46c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     46f:	83 c4 14             	add    $0x14,%esp
     472:	89 d8                	mov    %ebx,%eax
     474:	5b                   	pop    %ebx
     475:	5d                   	pop    %ebp
     476:	c3                   	ret    
     477:	89 f6                	mov    %esi,%esi
     479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000480 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	53                   	push   %ebx
     484:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     487:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     48e:	e8 4d 0d 00 00       	call   11e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     493:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     49a:	00 
     49b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     4a2:	00 
     4a3:	89 04 24             	mov    %eax,(%esp)
  cmd = malloc(sizeof(*cmd));
     4a6:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4a8:	e8 f3 07 00 00       	call   ca0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     4ad:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     4b0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     4b6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     4bc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4bf:	83 c4 14             	add    $0x14,%esp
     4c2:	89 d8                	mov    %ebx,%eax
     4c4:	5b                   	pop    %ebx
     4c5:	5d                   	pop    %ebp
     4c6:	c3                   	ret    
     4c7:	89 f6                	mov    %esi,%esi
     4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004d0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	53                   	push   %ebx
     4d4:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4d7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     4de:	e8 fd 0c 00 00       	call   11e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4e3:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     4ea:	00 
     4eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     4f2:	00 
     4f3:	89 04 24             	mov    %eax,(%esp)
  cmd = malloc(sizeof(*cmd));
     4f6:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4f8:	e8 a3 07 00 00       	call   ca0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     4fd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     500:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     506:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     509:	83 c4 14             	add    $0x14,%esp
     50c:	89 d8                	mov    %ebx,%eax
     50e:	5b                   	pop    %ebx
     50f:	5d                   	pop    %ebp
     510:	c3                   	ret    
     511:	eb 0d                	jmp    520 <gettoken>
     513:	90                   	nop
     514:	90                   	nop
     515:	90                   	nop
     516:	90                   	nop
     517:	90                   	nop
     518:	90                   	nop
     519:	90                   	nop
     51a:	90                   	nop
     51b:	90                   	nop
     51c:	90                   	nop
     51d:	90                   	nop
     51e:	90                   	nop
     51f:	90                   	nop

00000520 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
     523:	57                   	push   %edi
     524:	56                   	push   %esi
     525:	53                   	push   %ebx
     526:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;

  s = *ps;
     529:	8b 45 08             	mov    0x8(%ebp),%eax
{
     52c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     52f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     532:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     534:	39 df                	cmp    %ebx,%edi
     536:	72 0f                	jb     547 <gettoken+0x27>
     538:	eb 24                	jmp    55e <gettoken+0x3e>
     53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     540:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     543:	39 df                	cmp    %ebx,%edi
     545:	74 17                	je     55e <gettoken+0x3e>
     547:	0f be 07             	movsbl (%edi),%eax
     54a:	c7 04 24 50 19 00 00 	movl   $0x1950,(%esp)
     551:	89 44 24 04          	mov    %eax,0x4(%esp)
     555:	e8 66 07 00 00       	call   cc0 <strchr>
     55a:	85 c0                	test   %eax,%eax
     55c:	75 e2                	jne    540 <gettoken+0x20>
  if(q)
     55e:	85 f6                	test   %esi,%esi
     560:	74 02                	je     564 <gettoken+0x44>
    *q = s;
     562:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     564:	0f b6 0f             	movzbl (%edi),%ecx
     567:	0f be f1             	movsbl %cl,%esi
  switch(*s){
     56a:	80 f9 29             	cmp    $0x29,%cl
  ret = *s;
     56d:	89 f0                	mov    %esi,%eax
  switch(*s){
     56f:	7f 4f                	jg     5c0 <gettoken+0xa0>
     571:	80 f9 28             	cmp    $0x28,%cl
     574:	7d 55                	jge    5cb <gettoken+0xab>
     576:	84 c9                	test   %cl,%cl
     578:	0f 85 ca 00 00 00    	jne    648 <gettoken+0x128>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     57e:	8b 45 14             	mov    0x14(%ebp),%eax
     581:	85 c0                	test   %eax,%eax
     583:	74 05                	je     58a <gettoken+0x6a>
    *eq = s;
     585:	8b 45 14             	mov    0x14(%ebp),%eax
     588:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     58a:	39 df                	cmp    %ebx,%edi
     58c:	72 09                	jb     597 <gettoken+0x77>
     58e:	eb 1e                	jmp    5ae <gettoken+0x8e>
    s++;
     590:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     593:	39 df                	cmp    %ebx,%edi
     595:	74 17                	je     5ae <gettoken+0x8e>
     597:	0f be 07             	movsbl (%edi),%eax
     59a:	c7 04 24 50 19 00 00 	movl   $0x1950,(%esp)
     5a1:	89 44 24 04          	mov    %eax,0x4(%esp)
     5a5:	e8 16 07 00 00       	call   cc0 <strchr>
     5aa:	85 c0                	test   %eax,%eax
     5ac:	75 e2                	jne    590 <gettoken+0x70>
  *ps = s;
     5ae:	8b 45 08             	mov    0x8(%ebp),%eax
     5b1:	89 38                	mov    %edi,(%eax)
  return ret;
}
     5b3:	83 c4 1c             	add    $0x1c,%esp
     5b6:	89 f0                	mov    %esi,%eax
     5b8:	5b                   	pop    %ebx
     5b9:	5e                   	pop    %esi
     5ba:	5f                   	pop    %edi
     5bb:	5d                   	pop    %ebp
     5bc:	c3                   	ret    
     5bd:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     5c0:	80 f9 3e             	cmp    $0x3e,%cl
     5c3:	75 0b                	jne    5d0 <gettoken+0xb0>
    if(*s == '>'){
     5c5:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     5c9:	74 6d                	je     638 <gettoken+0x118>
    s++;
     5cb:	83 c7 01             	add    $0x1,%edi
     5ce:	eb ae                	jmp    57e <gettoken+0x5e>
  switch(*s){
     5d0:	7f 56                	jg     628 <gettoken+0x108>
     5d2:	83 e9 3b             	sub    $0x3b,%ecx
     5d5:	80 f9 01             	cmp    $0x1,%cl
     5d8:	76 f1                	jbe    5cb <gettoken+0xab>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5da:	39 fb                	cmp    %edi,%ebx
     5dc:	77 2b                	ja     609 <gettoken+0xe9>
     5de:	66 90                	xchg   %ax,%ax
     5e0:	eb 3b                	jmp    61d <gettoken+0xfd>
     5e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5e8:	0f be 07             	movsbl (%edi),%eax
     5eb:	c7 04 24 48 19 00 00 	movl   $0x1948,(%esp)
     5f2:	89 44 24 04          	mov    %eax,0x4(%esp)
     5f6:	e8 c5 06 00 00       	call   cc0 <strchr>
     5fb:	85 c0                	test   %eax,%eax
     5fd:	75 1e                	jne    61d <gettoken+0xfd>
      s++;
     5ff:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     602:	39 df                	cmp    %ebx,%edi
     604:	74 17                	je     61d <gettoken+0xfd>
     606:	0f be 07             	movsbl (%edi),%eax
     609:	89 44 24 04          	mov    %eax,0x4(%esp)
     60d:	c7 04 24 50 19 00 00 	movl   $0x1950,(%esp)
     614:	e8 a7 06 00 00       	call   cc0 <strchr>
     619:	85 c0                	test   %eax,%eax
     61b:	74 cb                	je     5e8 <gettoken+0xc8>
    ret = 'a';
     61d:	be 61 00 00 00       	mov    $0x61,%esi
     622:	e9 57 ff ff ff       	jmp    57e <gettoken+0x5e>
     627:	90                   	nop
  switch(*s){
     628:	80 f9 7c             	cmp    $0x7c,%cl
     62b:	74 9e                	je     5cb <gettoken+0xab>
     62d:	8d 76 00             	lea    0x0(%esi),%esi
     630:	eb a8                	jmp    5da <gettoken+0xba>
     632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      s++;
     638:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     63b:	be 2b 00 00 00       	mov    $0x2b,%esi
     640:	e9 39 ff ff ff       	jmp    57e <gettoken+0x5e>
     645:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     648:	80 f9 26             	cmp    $0x26,%cl
     64b:	75 8d                	jne    5da <gettoken+0xba>
     64d:	e9 79 ff ff ff       	jmp    5cb <gettoken+0xab>
     652:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	57                   	push   %edi
     664:	56                   	push   %esi
     665:	53                   	push   %ebx
     666:	83 ec 1c             	sub    $0x1c,%esp
     669:	8b 7d 08             	mov    0x8(%ebp),%edi
     66c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     66f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     671:	39 f3                	cmp    %esi,%ebx
     673:	72 0a                	jb     67f <peek+0x1f>
     675:	eb 1f                	jmp    696 <peek+0x36>
     677:	90                   	nop
    s++;
     678:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     67b:	39 f3                	cmp    %esi,%ebx
     67d:	74 17                	je     696 <peek+0x36>
     67f:	0f be 03             	movsbl (%ebx),%eax
     682:	c7 04 24 50 19 00 00 	movl   $0x1950,(%esp)
     689:	89 44 24 04          	mov    %eax,0x4(%esp)
     68d:	e8 2e 06 00 00       	call   cc0 <strchr>
     692:	85 c0                	test   %eax,%eax
     694:	75 e2                	jne    678 <peek+0x18>
  *ps = s;
     696:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     698:	0f be 13             	movsbl (%ebx),%edx
     69b:	31 c0                	xor    %eax,%eax
     69d:	84 d2                	test   %dl,%dl
     69f:	74 17                	je     6b8 <peek+0x58>
     6a1:	8b 45 10             	mov    0x10(%ebp),%eax
     6a4:	89 54 24 04          	mov    %edx,0x4(%esp)
     6a8:	89 04 24             	mov    %eax,(%esp)
     6ab:	e8 10 06 00 00       	call   cc0 <strchr>
     6b0:	85 c0                	test   %eax,%eax
     6b2:	0f 95 c0             	setne  %al
     6b5:	0f b6 c0             	movzbl %al,%eax
}
     6b8:	83 c4 1c             	add    $0x1c,%esp
     6bb:	5b                   	pop    %ebx
     6bc:	5e                   	pop    %esi
     6bd:	5f                   	pop    %edi
     6be:	5d                   	pop    %ebp
     6bf:	c3                   	ret    

000006c0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	57                   	push   %edi
     6c4:	56                   	push   %esi
     6c5:	53                   	push   %ebx
     6c6:	83 ec 3c             	sub    $0x3c,%esp
     6c9:	8b 75 0c             	mov    0xc(%ebp),%esi
     6cc:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6cf:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     6d0:	c7 44 24 08 19 13 00 	movl   $0x1319,0x8(%esp)
     6d7:	00 
     6d8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     6dc:	89 34 24             	mov    %esi,(%esp)
     6df:	e8 7c ff ff ff       	call   660 <peek>
     6e4:	85 c0                	test   %eax,%eax
     6e6:	0f 84 9c 00 00 00    	je     788 <parseredirs+0xc8>
    tok = gettoken(ps, es, 0, 0);
     6ec:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     6f3:	00 
     6f4:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     6fb:	00 
     6fc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     700:	89 34 24             	mov    %esi,(%esp)
     703:	e8 18 fe ff ff       	call   520 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     708:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     70c:	89 34 24             	mov    %esi,(%esp)
    tok = gettoken(ps, es, 0, 0);
     70f:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     711:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     714:	89 44 24 0c          	mov    %eax,0xc(%esp)
     718:	8d 45 e0             	lea    -0x20(%ebp),%eax
     71b:	89 44 24 08          	mov    %eax,0x8(%esp)
     71f:	e8 fc fd ff ff       	call   520 <gettoken>
     724:	83 f8 61             	cmp    $0x61,%eax
     727:	75 6a                	jne    793 <parseredirs+0xd3>
      panic("missing file for redirection");
    switch(tok){
     729:	83 ff 3c             	cmp    $0x3c,%edi
     72c:	74 42                	je     770 <parseredirs+0xb0>
     72e:	83 ff 3e             	cmp    $0x3e,%edi
     731:	74 05                	je     738 <parseredirs+0x78>
     733:	83 ff 2b             	cmp    $0x2b,%edi
     736:	75 98                	jne    6d0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     738:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     73f:	00 
     740:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     747:	00 
     748:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     74b:	89 44 24 08          	mov    %eax,0x8(%esp)
     74f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     752:	89 44 24 04          	mov    %eax,0x4(%esp)
     756:	8b 45 08             	mov    0x8(%ebp),%eax
     759:	89 04 24             	mov    %eax,(%esp)
     75c:	e8 6f fc ff ff       	call   3d0 <redircmd>
     761:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     764:	e9 67 ff ff ff       	jmp    6d0 <parseredirs+0x10>
     769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     770:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     777:	00 
     778:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     77f:	00 
     780:	eb c6                	jmp    748 <parseredirs+0x88>
     782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }
  return cmd;
}
     788:	8b 45 08             	mov    0x8(%ebp),%eax
     78b:	83 c4 3c             	add    $0x3c,%esp
     78e:	5b                   	pop    %ebx
     78f:	5e                   	pop    %esi
     790:	5f                   	pop    %edi
     791:	5d                   	pop    %ebp
     792:	c3                   	ret    
      panic("missing file for redirection");
     793:	c7 04 24 fc 12 00 00 	movl   $0x12fc,(%esp)
     79a:	e8 d1 f9 ff ff       	call   170 <panic>
     79f:	90                   	nop

000007a0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	57                   	push   %edi
     7a4:	56                   	push   %esi
     7a5:	53                   	push   %ebx
     7a6:	83 ec 3c             	sub    $0x3c,%esp
     7a9:	8b 75 08             	mov    0x8(%ebp),%esi
     7ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     7af:	c7 44 24 08 1c 13 00 	movl   $0x131c,0x8(%esp)
     7b6:	00 
     7b7:	89 34 24             	mov    %esi,(%esp)
     7ba:	89 7c 24 04          	mov    %edi,0x4(%esp)
     7be:	e8 9d fe ff ff       	call   660 <peek>
     7c3:	85 c0                	test   %eax,%eax
     7c5:	0f 85 a5 00 00 00    	jne    870 <parseexec+0xd0>
    return parseblock(ps, es);

  ret = execcmd();
     7cb:	e8 c0 fb ff ff       	call   390 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     7d0:	89 7c 24 08          	mov    %edi,0x8(%esp)
     7d4:	89 74 24 04          	mov    %esi,0x4(%esp)
     7d8:	89 04 24             	mov    %eax,(%esp)
  ret = execcmd();
     7db:	89 c3                	mov    %eax,%ebx
     7dd:	89 45 cc             	mov    %eax,-0x34(%ebp)
  ret = parseredirs(ret, ps, es);
     7e0:	e8 db fe ff ff       	call   6c0 <parseredirs>
  argc = 0;
     7e5:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  ret = parseredirs(ret, ps, es);
     7ec:	89 45 d0             	mov    %eax,-0x30(%ebp)
  while(!peek(ps, es, "|)&;")){
     7ef:	eb 1d                	jmp    80e <parseexec+0x6e>
     7f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     7f8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7fb:	89 7c 24 08          	mov    %edi,0x8(%esp)
     7ff:	89 74 24 04          	mov    %esi,0x4(%esp)
     803:	89 04 24             	mov    %eax,(%esp)
     806:	e8 b5 fe ff ff       	call   6c0 <parseredirs>
     80b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  while(!peek(ps, es, "|)&;")){
     80e:	c7 44 24 08 33 13 00 	movl   $0x1333,0x8(%esp)
     815:	00 
     816:	89 7c 24 04          	mov    %edi,0x4(%esp)
     81a:	89 34 24             	mov    %esi,(%esp)
     81d:	e8 3e fe ff ff       	call   660 <peek>
     822:	85 c0                	test   %eax,%eax
     824:	75 62                	jne    888 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     826:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     829:	89 44 24 0c          	mov    %eax,0xc(%esp)
     82d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     830:	89 44 24 08          	mov    %eax,0x8(%esp)
     834:	89 7c 24 04          	mov    %edi,0x4(%esp)
     838:	89 34 24             	mov    %esi,(%esp)
     83b:	e8 e0 fc ff ff       	call   520 <gettoken>
     840:	85 c0                	test   %eax,%eax
     842:	74 44                	je     888 <parseexec+0xe8>
    if(tok != 'a')
     844:	83 f8 61             	cmp    $0x61,%eax
     847:	75 61                	jne    8aa <parseexec+0x10a>
    cmd->argv[argc] = q;
     849:	8b 45 e0             	mov    -0x20(%ebp),%eax
     84c:	83 c3 04             	add    $0x4,%ebx
    argc++;
     84f:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    cmd->argv[argc] = q;
     853:	89 03                	mov    %eax,(%ebx)
    cmd->eargv[argc] = eq;
     855:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     858:	89 43 28             	mov    %eax,0x28(%ebx)
    if(argc >= MAXARGS)
     85b:	83 7d d4 0a          	cmpl   $0xa,-0x2c(%ebp)
     85f:	75 97                	jne    7f8 <parseexec+0x58>
      panic("too many args");
     861:	c7 04 24 25 13 00 00 	movl   $0x1325,(%esp)
     868:	e8 03 f9 ff ff       	call   170 <panic>
     86d:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     870:	89 7c 24 04          	mov    %edi,0x4(%esp)
     874:	89 34 24             	mov    %esi,(%esp)
     877:	e8 84 01 00 00       	call   a00 <parseblock>
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     87c:	83 c4 3c             	add    $0x3c,%esp
     87f:	5b                   	pop    %ebx
     880:	5e                   	pop    %esi
     881:	5f                   	pop    %edi
     882:	5d                   	pop    %ebp
     883:	c3                   	ret    
     884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     888:	8b 45 cc             	mov    -0x34(%ebp),%eax
     88b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     88e:	8d 04 90             	lea    (%eax,%edx,4),%eax
  cmd->argv[argc] = 0;
     891:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     898:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
  return ret;
     89f:	8b 45 d0             	mov    -0x30(%ebp),%eax
}
     8a2:	83 c4 3c             	add    $0x3c,%esp
     8a5:	5b                   	pop    %ebx
     8a6:	5e                   	pop    %esi
     8a7:	5f                   	pop    %edi
     8a8:	5d                   	pop    %ebp
     8a9:	c3                   	ret    
      panic("syntax");
     8aa:	c7 04 24 1e 13 00 00 	movl   $0x131e,(%esp)
     8b1:	e8 ba f8 ff ff       	call   170 <panic>
     8b6:	8d 76 00             	lea    0x0(%esi),%esi
     8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008c0 <parsepipe>:
{
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
     8c3:	57                   	push   %edi
     8c4:	56                   	push   %esi
     8c5:	53                   	push   %ebx
     8c6:	83 ec 1c             	sub    $0x1c,%esp
     8c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     8cf:	89 1c 24             	mov    %ebx,(%esp)
     8d2:	89 74 24 04          	mov    %esi,0x4(%esp)
     8d6:	e8 c5 fe ff ff       	call   7a0 <parseexec>
  if(peek(ps, es, "|")){
     8db:	c7 44 24 08 38 13 00 	movl   $0x1338,0x8(%esp)
     8e2:	00 
     8e3:	89 74 24 04          	mov    %esi,0x4(%esp)
     8e7:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseexec(ps, es);
     8ea:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     8ec:	e8 6f fd ff ff       	call   660 <peek>
     8f1:	85 c0                	test   %eax,%eax
     8f3:	75 0b                	jne    900 <parsepipe+0x40>
}
     8f5:	83 c4 1c             	add    $0x1c,%esp
     8f8:	89 f8                	mov    %edi,%eax
     8fa:	5b                   	pop    %ebx
     8fb:	5e                   	pop    %esi
     8fc:	5f                   	pop    %edi
     8fd:	5d                   	pop    %ebp
     8fe:	c3                   	ret    
     8ff:	90                   	nop
    gettoken(ps, es, 0, 0);
     900:	89 74 24 04          	mov    %esi,0x4(%esp)
     904:	89 1c 24             	mov    %ebx,(%esp)
     907:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     90e:	00 
     90f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     916:	00 
     917:	e8 04 fc ff ff       	call   520 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     91c:	89 74 24 04          	mov    %esi,0x4(%esp)
     920:	89 1c 24             	mov    %ebx,(%esp)
     923:	e8 98 ff ff ff       	call   8c0 <parsepipe>
     928:	89 7d 08             	mov    %edi,0x8(%ebp)
     92b:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     92e:	83 c4 1c             	add    $0x1c,%esp
     931:	5b                   	pop    %ebx
     932:	5e                   	pop    %esi
     933:	5f                   	pop    %edi
     934:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     935:	e9 f6 fa ff ff       	jmp    430 <pipecmd>
     93a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000940 <parseline>:
{
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	57                   	push   %edi
     944:	56                   	push   %esi
     945:	53                   	push   %ebx
     946:	83 ec 1c             	sub    $0x1c,%esp
     949:	8b 5d 08             	mov    0x8(%ebp),%ebx
     94c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     94f:	89 1c 24             	mov    %ebx,(%esp)
     952:	89 74 24 04          	mov    %esi,0x4(%esp)
     956:	e8 65 ff ff ff       	call   8c0 <parsepipe>
     95b:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     95d:	eb 27                	jmp    986 <parseline+0x46>
     95f:	90                   	nop
    gettoken(ps, es, 0, 0);
     960:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     967:	00 
     968:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     96f:	00 
     970:	89 74 24 04          	mov    %esi,0x4(%esp)
     974:	89 1c 24             	mov    %ebx,(%esp)
     977:	e8 a4 fb ff ff       	call   520 <gettoken>
    cmd = backcmd(cmd);
     97c:	89 3c 24             	mov    %edi,(%esp)
     97f:	e8 4c fb ff ff       	call   4d0 <backcmd>
     984:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     986:	c7 44 24 08 3a 13 00 	movl   $0x133a,0x8(%esp)
     98d:	00 
     98e:	89 74 24 04          	mov    %esi,0x4(%esp)
     992:	89 1c 24             	mov    %ebx,(%esp)
     995:	e8 c6 fc ff ff       	call   660 <peek>
     99a:	85 c0                	test   %eax,%eax
     99c:	75 c2                	jne    960 <parseline+0x20>
  if(peek(ps, es, ";")){
     99e:	c7 44 24 08 36 13 00 	movl   $0x1336,0x8(%esp)
     9a5:	00 
     9a6:	89 74 24 04          	mov    %esi,0x4(%esp)
     9aa:	89 1c 24             	mov    %ebx,(%esp)
     9ad:	e8 ae fc ff ff       	call   660 <peek>
     9b2:	85 c0                	test   %eax,%eax
     9b4:	75 0a                	jne    9c0 <parseline+0x80>
}
     9b6:	83 c4 1c             	add    $0x1c,%esp
     9b9:	89 f8                	mov    %edi,%eax
     9bb:	5b                   	pop    %ebx
     9bc:	5e                   	pop    %esi
     9bd:	5f                   	pop    %edi
     9be:	5d                   	pop    %ebp
     9bf:	c3                   	ret    
    gettoken(ps, es, 0, 0);
     9c0:	89 74 24 04          	mov    %esi,0x4(%esp)
     9c4:	89 1c 24             	mov    %ebx,(%esp)
     9c7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     9ce:	00 
     9cf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     9d6:	00 
     9d7:	e8 44 fb ff ff       	call   520 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     9dc:	89 74 24 04          	mov    %esi,0x4(%esp)
     9e0:	89 1c 24             	mov    %ebx,(%esp)
     9e3:	e8 58 ff ff ff       	call   940 <parseline>
     9e8:	89 7d 08             	mov    %edi,0x8(%ebp)
     9eb:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     9ee:	83 c4 1c             	add    $0x1c,%esp
     9f1:	5b                   	pop    %ebx
     9f2:	5e                   	pop    %esi
     9f3:	5f                   	pop    %edi
     9f4:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     9f5:	e9 86 fa ff ff       	jmp    480 <listcmd>
     9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a00 <parseblock>:
{
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	57                   	push   %edi
     a04:	56                   	push   %esi
     a05:	53                   	push   %ebx
     a06:	83 ec 1c             	sub    $0x1c,%esp
     a09:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a0c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     a0f:	c7 44 24 08 1c 13 00 	movl   $0x131c,0x8(%esp)
     a16:	00 
     a17:	89 1c 24             	mov    %ebx,(%esp)
     a1a:	89 74 24 04          	mov    %esi,0x4(%esp)
     a1e:	e8 3d fc ff ff       	call   660 <peek>
     a23:	85 c0                	test   %eax,%eax
     a25:	74 76                	je     a9d <parseblock+0x9d>
  gettoken(ps, es, 0, 0);
     a27:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a2e:	00 
     a2f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     a36:	00 
     a37:	89 74 24 04          	mov    %esi,0x4(%esp)
     a3b:	89 1c 24             	mov    %ebx,(%esp)
     a3e:	e8 dd fa ff ff       	call   520 <gettoken>
  cmd = parseline(ps, es);
     a43:	89 74 24 04          	mov    %esi,0x4(%esp)
     a47:	89 1c 24             	mov    %ebx,(%esp)
     a4a:	e8 f1 fe ff ff       	call   940 <parseline>
  if(!peek(ps, es, ")"))
     a4f:	c7 44 24 08 58 13 00 	movl   $0x1358,0x8(%esp)
     a56:	00 
     a57:	89 74 24 04          	mov    %esi,0x4(%esp)
     a5b:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseline(ps, es);
     a5e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     a60:	e8 fb fb ff ff       	call   660 <peek>
     a65:	85 c0                	test   %eax,%eax
     a67:	74 40                	je     aa9 <parseblock+0xa9>
  gettoken(ps, es, 0, 0);
     a69:	89 74 24 04          	mov    %esi,0x4(%esp)
     a6d:	89 1c 24             	mov    %ebx,(%esp)
     a70:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a77:	00 
     a78:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     a7f:	00 
     a80:	e8 9b fa ff ff       	call   520 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     a85:	89 74 24 08          	mov    %esi,0x8(%esp)
     a89:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a8d:	89 3c 24             	mov    %edi,(%esp)
     a90:	e8 2b fc ff ff       	call   6c0 <parseredirs>
}
     a95:	83 c4 1c             	add    $0x1c,%esp
     a98:	5b                   	pop    %ebx
     a99:	5e                   	pop    %esi
     a9a:	5f                   	pop    %edi
     a9b:	5d                   	pop    %ebp
     a9c:	c3                   	ret    
    panic("parseblock");
     a9d:	c7 04 24 3c 13 00 00 	movl   $0x133c,(%esp)
     aa4:	e8 c7 f6 ff ff       	call   170 <panic>
    panic("syntax - missing )");
     aa9:	c7 04 24 47 13 00 00 	movl   $0x1347,(%esp)
     ab0:	e8 bb f6 ff ff       	call   170 <panic>
     ab5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ac0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	53                   	push   %ebx
     ac4:	83 ec 14             	sub    $0x14,%esp
     ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     aca:	85 db                	test   %ebx,%ebx
     acc:	0f 84 8e 00 00 00    	je     b60 <nulterminate+0xa0>
    return 0;

  switch(cmd->type){
     ad2:	83 3b 05             	cmpl   $0x5,(%ebx)
     ad5:	77 49                	ja     b20 <nulterminate+0x60>
     ad7:	8b 03                	mov    (%ebx),%eax
     ad9:	ff 24 85 98 13 00 00 	jmp    *0x1398(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     ae0:	8b 43 04             	mov    0x4(%ebx),%eax
     ae3:	89 04 24             	mov    %eax,(%esp)
     ae6:	e8 d5 ff ff ff       	call   ac0 <nulterminate>
    nulterminate(lcmd->right);
     aeb:	8b 43 08             	mov    0x8(%ebx),%eax
     aee:	89 04 24             	mov    %eax,(%esp)
     af1:	e8 ca ff ff ff       	call   ac0 <nulterminate>
    break;
     af6:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     af8:	83 c4 14             	add    $0x14,%esp
     afb:	5b                   	pop    %ebx
     afc:	5d                   	pop    %ebp
     afd:	c3                   	ret    
     afe:	66 90                	xchg   %ax,%ax
    for(i=0; ecmd->argv[i]; i++)
     b00:	8b 4b 04             	mov    0x4(%ebx),%ecx
     b03:	89 d8                	mov    %ebx,%eax
     b05:	85 c9                	test   %ecx,%ecx
     b07:	74 17                	je     b20 <nulterminate+0x60>
     b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
     b10:	8b 50 2c             	mov    0x2c(%eax),%edx
     b13:	83 c0 04             	add    $0x4,%eax
     b16:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     b19:	8b 50 04             	mov    0x4(%eax),%edx
     b1c:	85 d2                	test   %edx,%edx
     b1e:	75 f0                	jne    b10 <nulterminate+0x50>
}
     b20:	83 c4 14             	add    $0x14,%esp
  switch(cmd->type){
     b23:	89 d8                	mov    %ebx,%eax
}
     b25:	5b                   	pop    %ebx
     b26:	5d                   	pop    %ebp
     b27:	c3                   	ret    
    nulterminate(bcmd->cmd);
     b28:	8b 43 04             	mov    0x4(%ebx),%eax
     b2b:	89 04 24             	mov    %eax,(%esp)
     b2e:	e8 8d ff ff ff       	call   ac0 <nulterminate>
}
     b33:	83 c4 14             	add    $0x14,%esp
    break;
     b36:	89 d8                	mov    %ebx,%eax
}
     b38:	5b                   	pop    %ebx
     b39:	5d                   	pop    %ebp
     b3a:	c3                   	ret    
     b3b:	90                   	nop
     b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(rcmd->cmd);
     b40:	8b 43 04             	mov    0x4(%ebx),%eax
     b43:	89 04 24             	mov    %eax,(%esp)
     b46:	e8 75 ff ff ff       	call   ac0 <nulterminate>
    *rcmd->efile = 0;
     b4b:	8b 43 0c             	mov    0xc(%ebx),%eax
     b4e:	c6 00 00             	movb   $0x0,(%eax)
}
     b51:	83 c4 14             	add    $0x14,%esp
    break;
     b54:	89 d8                	mov    %ebx,%eax
}
     b56:	5b                   	pop    %ebx
     b57:	5d                   	pop    %ebp
     b58:	c3                   	ret    
     b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
     b60:	31 c0                	xor    %eax,%eax
     b62:	eb 94                	jmp    af8 <nulterminate+0x38>
     b64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b70 <parsecmd>:
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	56                   	push   %esi
     b74:	53                   	push   %ebx
     b75:	83 ec 10             	sub    $0x10,%esp
  es = s + strlen(s);
     b78:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b7b:	89 1c 24             	mov    %ebx,(%esp)
     b7e:	e8 ed 00 00 00       	call   c70 <strlen>
     b83:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     b85:	8d 45 08             	lea    0x8(%ebp),%eax
     b88:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     b8c:	89 04 24             	mov    %eax,(%esp)
     b8f:	e8 ac fd ff ff       	call   940 <parseline>
  peek(&s, es, "");
     b94:	c7 44 24 08 e6 12 00 	movl   $0x12e6,0x8(%esp)
     b9b:	00 
     b9c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  cmd = parseline(&s, es);
     ba0:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     ba2:	8d 45 08             	lea    0x8(%ebp),%eax
     ba5:	89 04 24             	mov    %eax,(%esp)
     ba8:	e8 b3 fa ff ff       	call   660 <peek>
  if(s != es){
     bad:	8b 45 08             	mov    0x8(%ebp),%eax
     bb0:	39 d8                	cmp    %ebx,%eax
     bb2:	75 11                	jne    bc5 <parsecmd+0x55>
  nulterminate(cmd);
     bb4:	89 34 24             	mov    %esi,(%esp)
     bb7:	e8 04 ff ff ff       	call   ac0 <nulterminate>
}
     bbc:	83 c4 10             	add    $0x10,%esp
     bbf:	89 f0                	mov    %esi,%eax
     bc1:	5b                   	pop    %ebx
     bc2:	5e                   	pop    %esi
     bc3:	5d                   	pop    %ebp
     bc4:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     bc5:	89 44 24 08          	mov    %eax,0x8(%esp)
     bc9:	c7 44 24 04 5a 13 00 	movl   $0x135a,0x4(%esp)
     bd0:	00 
     bd1:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     bd8:	e8 83 03 00 00       	call   f60 <printf>
    panic("syntax");
     bdd:	c7 04 24 1e 13 00 00 	movl   $0x131e,(%esp)
     be4:	e8 87 f5 ff ff       	call   170 <panic>
     be9:	66 90                	xchg   %ax,%ax
     beb:	66 90                	xchg   %ax,%ax
     bed:	66 90                	xchg   %ax,%ax
     bef:	90                   	nop

00000bf0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	8b 45 08             	mov    0x8(%ebp),%eax
     bf6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     bf9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     bfa:	89 c2                	mov    %eax,%edx
     bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c00:	83 c1 01             	add    $0x1,%ecx
     c03:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     c07:	83 c2 01             	add    $0x1,%edx
     c0a:	84 db                	test   %bl,%bl
     c0c:	88 5a ff             	mov    %bl,-0x1(%edx)
     c0f:	75 ef                	jne    c00 <strcpy+0x10>
    ;
  return os;
}
     c11:	5b                   	pop    %ebx
     c12:	5d                   	pop    %ebp
     c13:	c3                   	ret    
     c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000c20 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	8b 55 08             	mov    0x8(%ebp),%edx
     c26:	53                   	push   %ebx
     c27:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     c2a:	0f b6 02             	movzbl (%edx),%eax
     c2d:	84 c0                	test   %al,%al
     c2f:	74 2d                	je     c5e <strcmp+0x3e>
     c31:	0f b6 19             	movzbl (%ecx),%ebx
     c34:	38 d8                	cmp    %bl,%al
     c36:	74 0e                	je     c46 <strcmp+0x26>
     c38:	eb 2b                	jmp    c65 <strcmp+0x45>
     c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c40:	38 c8                	cmp    %cl,%al
     c42:	75 15                	jne    c59 <strcmp+0x39>
    p++, q++;
     c44:	89 d9                	mov    %ebx,%ecx
     c46:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     c49:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     c4c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     c4f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
     c53:	84 c0                	test   %al,%al
     c55:	75 e9                	jne    c40 <strcmp+0x20>
     c57:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     c59:	29 c8                	sub    %ecx,%eax
}
     c5b:	5b                   	pop    %ebx
     c5c:	5d                   	pop    %ebp
     c5d:	c3                   	ret    
     c5e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
     c61:	31 c0                	xor    %eax,%eax
     c63:	eb f4                	jmp    c59 <strcmp+0x39>
     c65:	0f b6 cb             	movzbl %bl,%ecx
     c68:	eb ef                	jmp    c59 <strcmp+0x39>
     c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c70 <strlen>:

uint
strlen(const char *s)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     c76:	80 39 00             	cmpb   $0x0,(%ecx)
     c79:	74 12                	je     c8d <strlen+0x1d>
     c7b:	31 d2                	xor    %edx,%edx
     c7d:	8d 76 00             	lea    0x0(%esi),%esi
     c80:	83 c2 01             	add    $0x1,%edx
     c83:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     c87:	89 d0                	mov    %edx,%eax
     c89:	75 f5                	jne    c80 <strlen+0x10>
    ;
  return n;
}
     c8b:	5d                   	pop    %ebp
     c8c:	c3                   	ret    
  for(n = 0; s[n]; n++)
     c8d:	31 c0                	xor    %eax,%eax
}
     c8f:	5d                   	pop    %ebp
     c90:	c3                   	ret    
     c91:	eb 0d                	jmp    ca0 <memset>
     c93:	90                   	nop
     c94:	90                   	nop
     c95:	90                   	nop
     c96:	90                   	nop
     c97:	90                   	nop
     c98:	90                   	nop
     c99:	90                   	nop
     c9a:	90                   	nop
     c9b:	90                   	nop
     c9c:	90                   	nop
     c9d:	90                   	nop
     c9e:	90                   	nop
     c9f:	90                   	nop

00000ca0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	8b 55 08             	mov    0x8(%ebp),%edx
     ca6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     ca7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     caa:	8b 45 0c             	mov    0xc(%ebp),%eax
     cad:	89 d7                	mov    %edx,%edi
     caf:	fc                   	cld    
     cb0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     cb2:	89 d0                	mov    %edx,%eax
     cb4:	5f                   	pop    %edi
     cb5:	5d                   	pop    %ebp
     cb6:	c3                   	ret    
     cb7:	89 f6                	mov    %esi,%esi
     cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cc0 <strchr>:

char*
strchr(const char *s, char c)
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	8b 45 08             	mov    0x8(%ebp),%eax
     cc6:	53                   	push   %ebx
     cc7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
     cca:	0f b6 18             	movzbl (%eax),%ebx
     ccd:	84 db                	test   %bl,%bl
     ccf:	74 1d                	je     cee <strchr+0x2e>
    if(*s == c)
     cd1:	38 d3                	cmp    %dl,%bl
     cd3:	89 d1                	mov    %edx,%ecx
     cd5:	75 0d                	jne    ce4 <strchr+0x24>
     cd7:	eb 17                	jmp    cf0 <strchr+0x30>
     cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ce0:	38 ca                	cmp    %cl,%dl
     ce2:	74 0c                	je     cf0 <strchr+0x30>
  for(; *s; s++)
     ce4:	83 c0 01             	add    $0x1,%eax
     ce7:	0f b6 10             	movzbl (%eax),%edx
     cea:	84 d2                	test   %dl,%dl
     cec:	75 f2                	jne    ce0 <strchr+0x20>
      return (char*)s;
  return 0;
     cee:	31 c0                	xor    %eax,%eax
}
     cf0:	5b                   	pop    %ebx
     cf1:	5d                   	pop    %ebp
     cf2:	c3                   	ret    
     cf3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d00 <gets>:

char*
gets(char *buf, int max)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	57                   	push   %edi
     d04:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d05:	31 f6                	xor    %esi,%esi
{
     d07:	53                   	push   %ebx
     d08:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
     d0b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     d0e:	eb 31                	jmp    d41 <gets+0x41>
    cc = read(0, &c, 1);
     d10:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     d17:	00 
     d18:	89 7c 24 04          	mov    %edi,0x4(%esp)
     d1c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d23:	e8 0a 01 00 00       	call   e32 <read>
    if(cc < 1)
     d28:	85 c0                	test   %eax,%eax
     d2a:	7e 1d                	jle    d49 <gets+0x49>
      break;
    buf[i++] = c;
     d2c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
     d30:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
     d32:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
     d35:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
     d37:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     d3b:	74 0c                	je     d49 <gets+0x49>
     d3d:	3c 0a                	cmp    $0xa,%al
     d3f:	74 08                	je     d49 <gets+0x49>
  for(i=0; i+1 < max; ){
     d41:	8d 5e 01             	lea    0x1(%esi),%ebx
     d44:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     d47:	7c c7                	jl     d10 <gets+0x10>
      break;
  }
  buf[i] = '\0';
     d49:	8b 45 08             	mov    0x8(%ebp),%eax
     d4c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     d50:	83 c4 2c             	add    $0x2c,%esp
     d53:	5b                   	pop    %ebx
     d54:	5e                   	pop    %esi
     d55:	5f                   	pop    %edi
     d56:	5d                   	pop    %ebp
     d57:	c3                   	ret    
     d58:	90                   	nop
     d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d60 <stat>:

int
stat(const char *n, struct stat *st)
{
     d60:	55                   	push   %ebp
     d61:	89 e5                	mov    %esp,%ebp
     d63:	56                   	push   %esi
     d64:	53                   	push   %ebx
     d65:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d68:	8b 45 08             	mov    0x8(%ebp),%eax
     d6b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     d72:	00 
     d73:	89 04 24             	mov    %eax,(%esp)
     d76:	e8 df 00 00 00       	call   e5a <open>
  if(fd < 0)
     d7b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
     d7d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
     d7f:	78 27                	js     da8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
     d81:	8b 45 0c             	mov    0xc(%ebp),%eax
     d84:	89 1c 24             	mov    %ebx,(%esp)
     d87:	89 44 24 04          	mov    %eax,0x4(%esp)
     d8b:	e8 e2 00 00 00       	call   e72 <fstat>
  close(fd);
     d90:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     d93:	89 c6                	mov    %eax,%esi
  close(fd);
     d95:	e8 a8 00 00 00       	call   e42 <close>
  return r;
     d9a:	89 f0                	mov    %esi,%eax
}
     d9c:	83 c4 10             	add    $0x10,%esp
     d9f:	5b                   	pop    %ebx
     da0:	5e                   	pop    %esi
     da1:	5d                   	pop    %ebp
     da2:	c3                   	ret    
     da3:	90                   	nop
     da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     da8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     dad:	eb ed                	jmp    d9c <stat+0x3c>
     daf:	90                   	nop

00000db0 <atoi>:

int
atoi(const char *s)
{
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     db6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     db7:	0f be 11             	movsbl (%ecx),%edx
     dba:	8d 42 d0             	lea    -0x30(%edx),%eax
     dbd:	3c 09                	cmp    $0x9,%al
  n = 0;
     dbf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     dc4:	77 17                	ja     ddd <atoi+0x2d>
     dc6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     dc8:	83 c1 01             	add    $0x1,%ecx
     dcb:	8d 04 80             	lea    (%eax,%eax,4),%eax
     dce:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     dd2:	0f be 11             	movsbl (%ecx),%edx
     dd5:	8d 5a d0             	lea    -0x30(%edx),%ebx
     dd8:	80 fb 09             	cmp    $0x9,%bl
     ddb:	76 eb                	jbe    dc8 <atoi+0x18>
  return n;
}
     ddd:	5b                   	pop    %ebx
     dde:	5d                   	pop    %ebp
     ddf:	c3                   	ret    

00000de0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     de0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     de1:	31 d2                	xor    %edx,%edx
{
     de3:	89 e5                	mov    %esp,%ebp
     de5:	56                   	push   %esi
     de6:	8b 45 08             	mov    0x8(%ebp),%eax
     de9:	53                   	push   %ebx
     dea:	8b 5d 10             	mov    0x10(%ebp),%ebx
     ded:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
     df0:	85 db                	test   %ebx,%ebx
     df2:	7e 12                	jle    e06 <memmove+0x26>
     df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     df8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     dfc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     dff:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     e02:	39 da                	cmp    %ebx,%edx
     e04:	75 f2                	jne    df8 <memmove+0x18>
  return vdst;
}
     e06:	5b                   	pop    %ebx
     e07:	5e                   	pop    %esi
     e08:	5d                   	pop    %ebp
     e09:	c3                   	ret    

00000e0a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     e0a:	b8 01 00 00 00       	mov    $0x1,%eax
     e0f:	cd 40                	int    $0x40
     e11:	c3                   	ret    

00000e12 <exit>:
SYSCALL(exit)
     e12:	b8 02 00 00 00       	mov    $0x2,%eax
     e17:	cd 40                	int    $0x40
     e19:	c3                   	ret    

00000e1a <wait>:
SYSCALL(wait)
     e1a:	b8 03 00 00 00       	mov    $0x3,%eax
     e1f:	cd 40                	int    $0x40
     e21:	c3                   	ret    

00000e22 <waitpid>:
SYSCALL(waitpid)
     e22:	b8 16 00 00 00       	mov    $0x16,%eax
     e27:	cd 40                	int    $0x40
     e29:	c3                   	ret    

00000e2a <pipe>:
SYSCALL(pipe)
     e2a:	b8 04 00 00 00       	mov    $0x4,%eax
     e2f:	cd 40                	int    $0x40
     e31:	c3                   	ret    

00000e32 <read>:
SYSCALL(read)
     e32:	b8 05 00 00 00       	mov    $0x5,%eax
     e37:	cd 40                	int    $0x40
     e39:	c3                   	ret    

00000e3a <write>:
SYSCALL(write)
     e3a:	b8 10 00 00 00       	mov    $0x10,%eax
     e3f:	cd 40                	int    $0x40
     e41:	c3                   	ret    

00000e42 <close>:
SYSCALL(close)
     e42:	b8 15 00 00 00       	mov    $0x15,%eax
     e47:	cd 40                	int    $0x40
     e49:	c3                   	ret    

00000e4a <kill>:
SYSCALL(kill)
     e4a:	b8 06 00 00 00       	mov    $0x6,%eax
     e4f:	cd 40                	int    $0x40
     e51:	c3                   	ret    

00000e52 <exec>:
SYSCALL(exec)
     e52:	b8 07 00 00 00       	mov    $0x7,%eax
     e57:	cd 40                	int    $0x40
     e59:	c3                   	ret    

00000e5a <open>:
SYSCALL(open)
     e5a:	b8 0f 00 00 00       	mov    $0xf,%eax
     e5f:	cd 40                	int    $0x40
     e61:	c3                   	ret    

00000e62 <mknod>:
SYSCALL(mknod)
     e62:	b8 11 00 00 00       	mov    $0x11,%eax
     e67:	cd 40                	int    $0x40
     e69:	c3                   	ret    

00000e6a <unlink>:
SYSCALL(unlink)
     e6a:	b8 12 00 00 00       	mov    $0x12,%eax
     e6f:	cd 40                	int    $0x40
     e71:	c3                   	ret    

00000e72 <fstat>:
SYSCALL(fstat)
     e72:	b8 08 00 00 00       	mov    $0x8,%eax
     e77:	cd 40                	int    $0x40
     e79:	c3                   	ret    

00000e7a <link>:
SYSCALL(link)
     e7a:	b8 13 00 00 00       	mov    $0x13,%eax
     e7f:	cd 40                	int    $0x40
     e81:	c3                   	ret    

00000e82 <mkdir>:
SYSCALL(mkdir)
     e82:	b8 14 00 00 00       	mov    $0x14,%eax
     e87:	cd 40                	int    $0x40
     e89:	c3                   	ret    

00000e8a <chdir>:
SYSCALL(chdir)
     e8a:	b8 09 00 00 00       	mov    $0x9,%eax
     e8f:	cd 40                	int    $0x40
     e91:	c3                   	ret    

00000e92 <dup>:
SYSCALL(dup)
     e92:	b8 0a 00 00 00       	mov    $0xa,%eax
     e97:	cd 40                	int    $0x40
     e99:	c3                   	ret    

00000e9a <getpid>:
SYSCALL(getpid)
     e9a:	b8 0b 00 00 00       	mov    $0xb,%eax
     e9f:	cd 40                	int    $0x40
     ea1:	c3                   	ret    

00000ea2 <sbrk>:
SYSCALL(sbrk)
     ea2:	b8 0c 00 00 00       	mov    $0xc,%eax
     ea7:	cd 40                	int    $0x40
     ea9:	c3                   	ret    

00000eaa <sleep>:
SYSCALL(sleep)
     eaa:	b8 0d 00 00 00       	mov    $0xd,%eax
     eaf:	cd 40                	int    $0x40
     eb1:	c3                   	ret    

00000eb2 <uptime>:
SYSCALL(uptime)
     eb2:	b8 0e 00 00 00       	mov    $0xe,%eax
     eb7:	cd 40                	int    $0x40
     eb9:	c3                   	ret    
     eba:	66 90                	xchg   %ax,%ax
     ebc:	66 90                	xchg   %ax,%ax
     ebe:	66 90                	xchg   %ax,%ax

00000ec0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     ec0:	55                   	push   %ebp
     ec1:	89 e5                	mov    %esp,%ebp
     ec3:	57                   	push   %edi
     ec4:	56                   	push   %esi
     ec5:	89 c6                	mov    %eax,%esi
     ec7:	53                   	push   %ebx
     ec8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ecb:	8b 5d 08             	mov    0x8(%ebp),%ebx
     ece:	85 db                	test   %ebx,%ebx
     ed0:	74 09                	je     edb <printint+0x1b>
     ed2:	89 d0                	mov    %edx,%eax
     ed4:	c1 e8 1f             	shr    $0x1f,%eax
     ed7:	84 c0                	test   %al,%al
     ed9:	75 75                	jne    f50 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     edb:	89 d0                	mov    %edx,%eax
  neg = 0;
     edd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     ee4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
     ee7:	31 ff                	xor    %edi,%edi
     ee9:	89 ce                	mov    %ecx,%esi
     eeb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     eee:	eb 02                	jmp    ef2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
     ef0:	89 cf                	mov    %ecx,%edi
     ef2:	31 d2                	xor    %edx,%edx
     ef4:	f7 f6                	div    %esi
     ef6:	8d 4f 01             	lea    0x1(%edi),%ecx
     ef9:	0f b6 92 b7 13 00 00 	movzbl 0x13b7(%edx),%edx
  }while((x /= base) != 0);
     f00:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     f02:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
     f05:	75 e9                	jne    ef0 <printint+0x30>
  if(neg)
     f07:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
     f0a:	89 c8                	mov    %ecx,%eax
     f0c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
     f0f:	85 d2                	test   %edx,%edx
     f11:	74 08                	je     f1b <printint+0x5b>
    buf[i++] = '-';
     f13:	8d 4f 02             	lea    0x2(%edi),%ecx
     f16:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
     f1b:	8d 79 ff             	lea    -0x1(%ecx),%edi
     f1e:	66 90                	xchg   %ax,%ax
     f20:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
     f25:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
     f28:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f2f:	00 
     f30:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     f34:	89 34 24             	mov    %esi,(%esp)
     f37:	88 45 d7             	mov    %al,-0x29(%ebp)
     f3a:	e8 fb fe ff ff       	call   e3a <write>
  while(--i >= 0)
     f3f:	83 ff ff             	cmp    $0xffffffff,%edi
     f42:	75 dc                	jne    f20 <printint+0x60>
    putc(fd, buf[i]);
}
     f44:	83 c4 4c             	add    $0x4c,%esp
     f47:	5b                   	pop    %ebx
     f48:	5e                   	pop    %esi
     f49:	5f                   	pop    %edi
     f4a:	5d                   	pop    %ebp
     f4b:	c3                   	ret    
     f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
     f50:	89 d0                	mov    %edx,%eax
     f52:	f7 d8                	neg    %eax
    neg = 1;
     f54:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
     f5b:	eb 87                	jmp    ee4 <printint+0x24>
     f5d:	8d 76 00             	lea    0x0(%esi),%esi

00000f60 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     f64:	31 ff                	xor    %edi,%edi
{
     f66:	56                   	push   %esi
     f67:	53                   	push   %ebx
     f68:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f6b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
     f6e:	8d 45 10             	lea    0x10(%ebp),%eax
{
     f71:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
     f74:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
     f77:	0f b6 13             	movzbl (%ebx),%edx
     f7a:	83 c3 01             	add    $0x1,%ebx
     f7d:	84 d2                	test   %dl,%dl
     f7f:	75 39                	jne    fba <printf+0x5a>
     f81:	e9 c2 00 00 00       	jmp    1048 <printf+0xe8>
     f86:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     f88:	83 fa 25             	cmp    $0x25,%edx
     f8b:	0f 84 bf 00 00 00    	je     1050 <printf+0xf0>
  write(fd, &c, 1);
     f91:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     f94:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f9b:	00 
     f9c:	89 44 24 04          	mov    %eax,0x4(%esp)
     fa0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
     fa3:	88 55 e2             	mov    %dl,-0x1e(%ebp)
  write(fd, &c, 1);
     fa6:	e8 8f fe ff ff       	call   e3a <write>
     fab:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
     fae:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     fb2:	84 d2                	test   %dl,%dl
     fb4:	0f 84 8e 00 00 00    	je     1048 <printf+0xe8>
    if(state == 0){
     fba:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     fbc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
     fbf:	74 c7                	je     f88 <printf+0x28>
      }
    } else if(state == '%'){
     fc1:	83 ff 25             	cmp    $0x25,%edi
     fc4:	75 e5                	jne    fab <printf+0x4b>
      if(c == 'd'){
     fc6:	83 fa 64             	cmp    $0x64,%edx
     fc9:	0f 84 31 01 00 00    	je     1100 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     fcf:	25 f7 00 00 00       	and    $0xf7,%eax
     fd4:	83 f8 70             	cmp    $0x70,%eax
     fd7:	0f 84 83 00 00 00    	je     1060 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     fdd:	83 fa 73             	cmp    $0x73,%edx
     fe0:	0f 84 a2 00 00 00    	je     1088 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     fe6:	83 fa 63             	cmp    $0x63,%edx
     fe9:	0f 84 35 01 00 00    	je     1124 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     fef:	83 fa 25             	cmp    $0x25,%edx
     ff2:	0f 84 e0 00 00 00    	je     10d8 <printf+0x178>
  write(fd, &c, 1);
     ff8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     ffb:	83 c3 01             	add    $0x1,%ebx
     ffe:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1005:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1006:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    1008:	89 44 24 04          	mov    %eax,0x4(%esp)
    100c:	89 34 24             	mov    %esi,(%esp)
    100f:	89 55 d0             	mov    %edx,-0x30(%ebp)
    1012:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
    1016:	e8 1f fe ff ff       	call   e3a <write>
        putc(fd, c);
    101b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
    101e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1021:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1028:	00 
    1029:	89 44 24 04          	mov    %eax,0x4(%esp)
    102d:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
    1030:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    1033:	e8 02 fe ff ff       	call   e3a <write>
  for(i = 0; fmt[i]; i++){
    1038:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    103c:	84 d2                	test   %dl,%dl
    103e:	0f 85 76 ff ff ff    	jne    fba <printf+0x5a>
    1044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
}
    1048:	83 c4 3c             	add    $0x3c,%esp
    104b:	5b                   	pop    %ebx
    104c:	5e                   	pop    %esi
    104d:	5f                   	pop    %edi
    104e:	5d                   	pop    %ebp
    104f:	c3                   	ret    
        state = '%';
    1050:	bf 25 00 00 00       	mov    $0x25,%edi
    1055:	e9 51 ff ff ff       	jmp    fab <printf+0x4b>
    105a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1060:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1063:	b9 10 00 00 00       	mov    $0x10,%ecx
      state = 0;
    1068:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
    106a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1071:	8b 10                	mov    (%eax),%edx
    1073:	89 f0                	mov    %esi,%eax
    1075:	e8 46 fe ff ff       	call   ec0 <printint>
        ap++;
    107a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    107e:	e9 28 ff ff ff       	jmp    fab <printf+0x4b>
    1083:	90                   	nop
    1084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1088:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
    108b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
    108f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
    1091:	b8 b0 13 00 00       	mov    $0x13b0,%eax
    1096:	85 ff                	test   %edi,%edi
    1098:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
    109b:	0f b6 07             	movzbl (%edi),%eax
    109e:	84 c0                	test   %al,%al
    10a0:	74 2a                	je     10cc <printf+0x16c>
    10a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10a8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    10ab:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
    10ae:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
    10b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    10b8:	00 
    10b9:	89 44 24 04          	mov    %eax,0x4(%esp)
    10bd:	89 34 24             	mov    %esi,(%esp)
    10c0:	e8 75 fd ff ff       	call   e3a <write>
        while(*s != 0){
    10c5:	0f b6 07             	movzbl (%edi),%eax
    10c8:	84 c0                	test   %al,%al
    10ca:	75 dc                	jne    10a8 <printf+0x148>
      state = 0;
    10cc:	31 ff                	xor    %edi,%edi
    10ce:	e9 d8 fe ff ff       	jmp    fab <printf+0x4b>
    10d3:	90                   	nop
    10d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    10d8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
    10db:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    10dd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    10e4:	00 
    10e5:	89 44 24 04          	mov    %eax,0x4(%esp)
    10e9:	89 34 24             	mov    %esi,(%esp)
    10ec:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
    10f0:	e8 45 fd ff ff       	call   e3a <write>
    10f5:	e9 b1 fe ff ff       	jmp    fab <printf+0x4b>
    10fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1100:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1103:	b9 0a 00 00 00       	mov    $0xa,%ecx
      state = 0;
    1108:	66 31 ff             	xor    %di,%di
        printint(fd, *ap, 10, 1);
    110b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1112:	8b 10                	mov    (%eax),%edx
    1114:	89 f0                	mov    %esi,%eax
    1116:	e8 a5 fd ff ff       	call   ec0 <printint>
        ap++;
    111b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    111f:	e9 87 fe ff ff       	jmp    fab <printf+0x4b>
        putc(fd, *ap);
    1124:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
    1127:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
    1129:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    112b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1132:	00 
    1133:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
    1136:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1139:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    113c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1140:	e8 f5 fc ff ff       	call   e3a <write>
        ap++;
    1145:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1149:	e9 5d fe ff ff       	jmp    fab <printf+0x4b>
    114e:	66 90                	xchg   %ax,%ax

00001150 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1150:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1151:	a1 c4 19 00 00       	mov    0x19c4,%eax
{
    1156:	89 e5                	mov    %esp,%ebp
    1158:	57                   	push   %edi
    1159:	56                   	push   %esi
    115a:	53                   	push   %ebx
    115b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    115e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
    1160:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1163:	39 d0                	cmp    %edx,%eax
    1165:	72 11                	jb     1178 <free+0x28>
    1167:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1168:	39 c8                	cmp    %ecx,%eax
    116a:	72 04                	jb     1170 <free+0x20>
    116c:	39 ca                	cmp    %ecx,%edx
    116e:	72 10                	jb     1180 <free+0x30>
    1170:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1172:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1174:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1176:	73 f0                	jae    1168 <free+0x18>
    1178:	39 ca                	cmp    %ecx,%edx
    117a:	72 04                	jb     1180 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    117c:	39 c8                	cmp    %ecx,%eax
    117e:	72 f0                	jb     1170 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1180:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1183:	8d 3c f2             	lea    (%edx,%esi,8),%edi
    1186:	39 cf                	cmp    %ecx,%edi
    1188:	74 1e                	je     11a8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    118a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    118d:	8b 48 04             	mov    0x4(%eax),%ecx
    1190:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    1193:	39 f2                	cmp    %esi,%edx
    1195:	74 28                	je     11bf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1197:	89 10                	mov    %edx,(%eax)
  freep = p;
    1199:	a3 c4 19 00 00       	mov    %eax,0x19c4
}
    119e:	5b                   	pop    %ebx
    119f:	5e                   	pop    %esi
    11a0:	5f                   	pop    %edi
    11a1:	5d                   	pop    %ebp
    11a2:	c3                   	ret    
    11a3:	90                   	nop
    11a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    11a8:	03 71 04             	add    0x4(%ecx),%esi
    11ab:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    11ae:	8b 08                	mov    (%eax),%ecx
    11b0:	8b 09                	mov    (%ecx),%ecx
    11b2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    11b5:	8b 48 04             	mov    0x4(%eax),%ecx
    11b8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    11bb:	39 f2                	cmp    %esi,%edx
    11bd:	75 d8                	jne    1197 <free+0x47>
    p->s.size += bp->s.size;
    11bf:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
    11c2:	a3 c4 19 00 00       	mov    %eax,0x19c4
    p->s.size += bp->s.size;
    11c7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    11ca:	8b 53 f8             	mov    -0x8(%ebx),%edx
    11cd:	89 10                	mov    %edx,(%eax)
}
    11cf:	5b                   	pop    %ebx
    11d0:	5e                   	pop    %esi
    11d1:	5f                   	pop    %edi
    11d2:	5d                   	pop    %ebp
    11d3:	c3                   	ret    
    11d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000011e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	57                   	push   %edi
    11e4:	56                   	push   %esi
    11e5:	53                   	push   %ebx
    11e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    11ec:	8b 1d c4 19 00 00    	mov    0x19c4,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11f2:	8d 48 07             	lea    0x7(%eax),%ecx
    11f5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
    11f8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11fa:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
    11fd:	0f 84 9b 00 00 00    	je     129e <malloc+0xbe>
    1203:	8b 13                	mov    (%ebx),%edx
    1205:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1208:	39 fe                	cmp    %edi,%esi
    120a:	76 64                	jbe    1270 <malloc+0x90>
    120c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
    1213:	bb 00 80 00 00       	mov    $0x8000,%ebx
    1218:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    121b:	eb 0e                	jmp    122b <malloc+0x4b>
    121d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1220:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1222:	8b 78 04             	mov    0x4(%eax),%edi
    1225:	39 fe                	cmp    %edi,%esi
    1227:	76 4f                	jbe    1278 <malloc+0x98>
    1229:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    122b:	3b 15 c4 19 00 00    	cmp    0x19c4,%edx
    1231:	75 ed                	jne    1220 <malloc+0x40>
  if(nu < 4096)
    1233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1236:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    123c:	bf 00 10 00 00       	mov    $0x1000,%edi
    1241:	0f 43 fe             	cmovae %esi,%edi
    1244:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
    1247:	89 04 24             	mov    %eax,(%esp)
    124a:	e8 53 fc ff ff       	call   ea2 <sbrk>
  if(p == (char*)-1)
    124f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1252:	74 18                	je     126c <malloc+0x8c>
  hp->s.size = nu;
    1254:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    1257:	83 c0 08             	add    $0x8,%eax
    125a:	89 04 24             	mov    %eax,(%esp)
    125d:	e8 ee fe ff ff       	call   1150 <free>
  return freep;
    1262:	8b 15 c4 19 00 00    	mov    0x19c4,%edx
      if((p = morecore(nunits)) == 0)
    1268:	85 d2                	test   %edx,%edx
    126a:	75 b4                	jne    1220 <malloc+0x40>
        return 0;
    126c:	31 c0                	xor    %eax,%eax
    126e:	eb 20                	jmp    1290 <malloc+0xb0>
    if(p->s.size >= nunits){
    1270:	89 d0                	mov    %edx,%eax
    1272:	89 da                	mov    %ebx,%edx
    1274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1278:	39 fe                	cmp    %edi,%esi
    127a:	74 1c                	je     1298 <malloc+0xb8>
        p->s.size -= nunits;
    127c:	29 f7                	sub    %esi,%edi
    127e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
    1281:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
    1284:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    1287:	89 15 c4 19 00 00    	mov    %edx,0x19c4
      return (void*)(p + 1);
    128d:	83 c0 08             	add    $0x8,%eax
  }
}
    1290:	83 c4 1c             	add    $0x1c,%esp
    1293:	5b                   	pop    %ebx
    1294:	5e                   	pop    %esi
    1295:	5f                   	pop    %edi
    1296:	5d                   	pop    %ebp
    1297:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1298:	8b 08                	mov    (%eax),%ecx
    129a:	89 0a                	mov    %ecx,(%edx)
    129c:	eb e9                	jmp    1287 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
    129e:	c7 05 c4 19 00 00 c8 	movl   $0x19c8,0x19c4
    12a5:	19 00 00 
    base.s.size = 0;
    12a8:	ba c8 19 00 00       	mov    $0x19c8,%edx
    base.s.ptr = freep = prevp = &base;
    12ad:	c7 05 c8 19 00 00 c8 	movl   $0x19c8,0x19c8
    12b4:	19 00 00 
    base.s.size = 0;
    12b7:	c7 05 cc 19 00 00 00 	movl   $0x0,0x19cc
    12be:	00 00 00 
    12c1:	e9 46 ff ff ff       	jmp    120c <malloc+0x2c>
