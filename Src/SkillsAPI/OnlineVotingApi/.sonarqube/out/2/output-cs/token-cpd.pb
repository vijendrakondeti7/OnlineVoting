õ4
a/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Controllers/RegisterController.cs
	namespace 	
OnlineVotingApi
 
. 
Controllers %
{ 
[ 
Route 

(
 
$str 
) 
] 
public 

class 
RegisterController #
:$ %

Controller& 0
{ 
private 
readonly  
IOnlinevotingService -!
_ionlinevotingservice. C
;C D
public 
RegisterController !
(! " 
IOnlinevotingService" 6
onlinevotingService7 J
)J K
{ 	!
_ionlinevotingservice !
=" #
onlinevotingService$ 7
;7 8
} 	
[ 	
Route	 
( 
$str !
)! "
]" #
[ 	
HttpGet	 
] 
public 
async 
Task 
< 
ActionResult &
>& '
GetAadharDetails( 8
(8 9
long9 =
Anumber> E
)E F
{ 	
try 
{ 

AadharCard 
AadharDetails (
=) *
await+ 0!
_ionlinevotingservice1 F
.F G
LoadAdharDetailsG W
(W X
AnumberX _
)_ `
;` a
return 
AadharDetails $
!=% '
null( ,
?- .
Ok/ 1
(1 2
AadharDetails2 ?
)? @
:A B
OkC E
(E F
$strF ]
)] ^
;^ _
}   
catch!! 
(!! 
	Exception!! 
)!! 
{"" 
return$$ 

BadRequest$$ !
($$! "
)$$" #
;$$# $
}%% 
}(( 	
[** 	
Route**	 
(** 
$str** "
)**" #
]**# $
[++ 	
HttpPost++	 
]++ 
public,, 
async,, 
Task,, 
<,, 
ActionResult,, &
>,,& '
VoterRegistration,,( 9
(,,9 :
[,,: ;
	FromQuery,,; D
],,D E
long,,F J
AdharNumber,,K V
,,,V W
string,,X ^
state,,_ d
),,d e
{-- 	
try.. 
{// 
var00 
voterID00 
=00 
await00 #!
_ionlinevotingservice00$ 9
.009 :
RegisterVoter00: G
(00G H
AdharNumber00H S
,00S T
state00U Z
)00Z [
;00[ \
return11 
voterID11 
!=11 !
$num11" #
?11$ %
Ok11& (
(11( )
voterID11) 0
)110 1
:112 3

BadRequest114 >
(11> ?
)11? @
;11@ A
}33 
catch44 
(44 
	Exception44 
)44 
{55 
return66 

BadRequest66 !
(66! "
)66" #
;66# $
}77 
};; 	
[<< 	
Route<<	 
(<< 
$str<< 
)<< 
]<< 
[== 	
HttpGet==	 
]== 
public>> 
IActionResult>> 
GenerateOTP>> (
(>>( )
[>>) *
	FromQuery>>* 3
]>>3 4
long>>5 9
anumber>>: A
)>>A B
{?? 	
try@@ 
{AA 
stringBB 
phoneNumberBB "
=BB# $!
_ionlinevotingserviceBB% :
.BB: ;
GenerateOtpBB; F
(BBF G
anumberBBG N
)BBN O
;BBO P
ifCC 
(CC 
phoneNumberCC 
!=CC  "
nullCC# '
)CC' (
{DD 
boolEE 
resultEE 
=EE  !
SendotpEE" )
(EE) *
phoneNumberEE* 5
)EE5 6
;EE6 7
returnFF 
OkFF 
(FF 
resultFF $
)FF$ %
;FF% &
}GG 
elseHH 
{II 
returnJJ 

BadRequestJJ %
(JJ% &
falseJJ& +
)JJ+ ,
;JJ, -
}KK 
}LL 
catchNN 
(NN 
	ExceptionNN 
exNN 
)NN  
{OO 
returnPP 

BadRequestPP !
(PP! "
exPP" $
.PP$ %
MessagePP% ,
)PP, -
;PP- .
}QQ 
}SS 	
privateTT 
boolTT 
SendotpTT 
(TT 
stringTT #
phonenumbersTT$ 0
)TT0 1
{UU 	
tryWW 
{XX 
RandomYY 
randomYY 
=YY 
newYY  #
(YY# $
)YY$ %
;YY% &
intZZ 
otpZZ 
=ZZ 
randomZZ  
.ZZ  !
NextZZ! %
(ZZ% &
$numZZ& ,
,ZZ, -
$numZZ. 4
)ZZ4 5
;ZZ5 6
string[[ 
message[[ 
=[[  
$"[[! #
$str[[# :
{[[: ;
otp[[; >
}[[> ?
"[[? @
;[[@ A
string\\ 

accountSid\\ !
=\\" #
$str\\$ H
;\\H I
string]] 
	authToken]]  
=]]! "
$str]]# E
;]]E F
string^^ 
from^^ 
=^^ 
$str^^ ,
;^^, -
TwilioClient__ 
.__ 
Init__ !
(__! "

accountSid__" ,
,__, -
	authToken__. 7
)__7 8
;__8 9
MessageResource`` 
response``  (
=``) *
MessageResource``+ :
.``: ;
Create``; A
(``A B
bodyaa 
:aa 
messageaa  
,aa  !
frombb 
:bb 
frombb 
,bb 
tocc 
:cc 
newcc 
Twiliocc !
.cc! "
Typescc" '
.cc' (
PhoneNumbercc( 3
(cc3 4
phonenumberscc4 @
)cc@ A
)dd 
;dd 
HttpContextee 
.ee 
Sessionee #
.ee# $
	SetStringee$ -
(ee- .
$stree. :
,ee: ;
otpee< ?
.ee? @
ToStringee@ H
(eeH I
)eeI J
)eeJ K
;eeK L
returnff 
trueff 
;ff 
}gg 
catchhh 
{ii 
returnkk 
falsekk 
;kk 
}ll 
}nn 	
}oo 
}pp œ,
e/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Controllers/VotingModuleController.cs
	namespace 	
OnlineVotingApi
 
. 
Controllers %
{ 
[ 
Route 

(
 
$str 
) 
] 
[ 
	Authorize 
] 
public 

class "
VotingModuleController '
:( )

Controller* 4
{ 
private 
readonly  
IOnlinevotingService -!
_ionlinevotingservice. C
;C D
public "
VotingModuleController %
(% & 
IOnlinevotingService& :
onlinevotingService; N
)N O
{ 	!
_ionlinevotingservice !
=" #
onlinevotingService$ 7
;7 8
} 	
[ 	
AllowAnonymous	 
] 
[ 	
Route	 
( 
$str !
)! "
]" #
[ 	
HttpGet	 
] 
public 
IActionResult 
ValidateOtp (
(( )
string) /
otp0 3
,3 4
long5 9
anumber: A
)A B
{ 	
try 
{ 
string!! 

sessionOtp!! !
=!!" #
HttpContext!!$ /
.!!/ 0
Session!!0 7
.!!7 8
	GetString!!8 A
(!!A B
$str!!B N
)!!N O
;!!O P
if## 
(## 

sessionOtp## 
==## !
otp##" %
)##% &
{$$ 
SecurityToken%% !
token%%" '
=%%( )!
_ionlinevotingservice%%* ?
.%%? @
GenerateJWToken%%@ O
(%%O P
anumber%%P W
)%%W X
;%%X Y
HttpContext&& 
.&&  
Session&&  '
.&&' (
	SetString&&( 1
(&&1 2
$str&&2 ?
,&&? @
token&&A F
.&&F G
ToString&&G O
(&&O P
)&&P Q
)&&Q R
;&&R S
return'' 
Ok'' 
('' 
new'' !
{''" #
token''$ )
=''* +
new'', /#
JwtSecurityTokenHandler''0 G
(''G H
)''H I
.''I J

WriteToken''J T
(''T U
token''U Z
)''Z [
}''\ ]
)''] ^
;''^ _
}(( 
return)) 
Unauthorized)) #
())# $
)))$ %
;))% &
}** 
catch++ 
(++ 
	Exception++ 
ex++ 
)++  
{,, 
return.. 

BadRequest.. !
(..! "
ex.." $
...$ %
Message..% ,
).., -
;..- .
}// 
}11 	
[22 	
Route22	 
(22 
$str22 !
)22! "
]22" #
[33 	
HttpGet33	 
]33 
public44 
IEnumerable44 
<44 "
ElectionCandidatesList44 1
>441 2
GetCandidatesList443 D
(44D E
string44E K
sname44L Q
,44Q R
string44S Y
dname44Z _
)44_ `
{55 	
var88 
result88 
=88 !
_ionlinevotingservice88 .
.88. /
GetCandiatesList88/ ?
(88? @
sname88@ E
,88E F
dname88G L
)88L M
;88M N
return:: 
(:: 
IEnumerable:: 
<::  "
ElectionCandidatesList::  6
>::6 7
)::7 8
result::8 >
;::> ?
};; 	
[== 	
Route==	 
(== 
$str== 
)== 
]== 
[>> 	
HttpPost>>	 
]>> 
public?? 
ActionResult?? 

SubmitVote?? &
(??& '
int??' *
cid??+ .
,??. /
long??0 4
anumber??5 <
,??< =
string??> D
token??E J
)??J K
{@@ 	
tryAA 
{BB 
varCC 
tokenToBeValidatedCC &
=CC' (
HttpContextCC) 4
.CC4 5
RequestCC5 <
.CC< =
HeadersCC= D
[CCD E
$strCCE T
]CCT U
.CCU V
FirstOrDefaultCCV d
(CCd e
)CCe f
?CCf g
.CCg h
SplitCCh m
(CCm n
$strCCn q
)CCq r
.CCr s
LastCCs w
(CCw x
)CCx y
;CCy z
ifDD 
(DD 
tokenToBeValidatedDD &
==DD' )
tokenDD* /
)DD/ 0
{EE 
returnHH !
_ionlinevotingserviceHH 0
.HH0 1

SubmitVoteHH1 ;
(HH; <
cidHH< ?
,HH? @
tokenToBeValidatedHHA S
,HHS T
anumberHHU \
)HH\ ]
?II 
OkII 
(II 
$strII :
)II: ;
:JJ 
OkJJ 
(JJ 
$strJJ 5
)JJ5 6
;JJ6 7
}LL 
elseMM 
{NN 
returnOO 

BadRequestOO %
(OO% &
$strOO& 4
)OO4 5
;OO5 6
}PP 
}RR 
catchSS 
(SS 
	ExceptionSS 
exSS 
)SS  
{TT 
returnVV 

BadRequestVV !
(VV! "
$"VV" $
$strVV$ S
{VVS T
exVVT V
.VVV W
MessageVVW ^
}VV^ _
"VV_ `
)VV` a
;VVa b
}WW 
}XX 	
}YY 
}ZZ Ë
d/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/DataContext/OnlineVotingdbContext.cs
	namespace 	
OnlineVotingApi
 
. 
DataContext %
{ 
public 

class !
OnlineVotingdbContext &
:' (
	DbContext) 2
{ 
public		 !
OnlineVotingdbContext		 $
(		$ %
DbContextOptions		% 5
<		5 6!
OnlineVotingdbContext		6 K
>		K L
options		M T
)		T U
:		V W
base		X \
(		\ ]
options		] d
)		d e
{

 	
} 	
public 
DbSet 
< 

AadharCard 
>  

AadharCard! +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public 
DbSet 
< 
Voter 
> 
Voter !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
DbSet 
< 
DeceasedCandidates '
>' (
DeceasedCandidates) ;
{< =
get> A
;A B
setC F
;F G
}H I
public 
DbSet 
< 
State 
> 
States "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
DbSet 
< 
	Districts 
> 
	Districts  )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public 
DbSet 
<  
AssemblyConstituency )
>) * 
Assemblyconstituency+ ?
{@ A
getB E
;E F
setG J
;J K
}L M
public 
DbSet 
< "
ElectionCandidatesList +
>+ ,"
ElectionCandidatesList- C
{D E
getF I
;I J
setK N
;N O
}P Q
public 
DbSet 
< 
SubmittedVote "
>" #
submittedVote$ 1
{2 3
get4 7
;7 8
set9 <
;< =
}> ?
} 
} ﬂ
W/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/IOnlinevotingService.cs
	namespace 	
OnlineVotingApi
 
{ 
public		 

	interface		  
IOnlinevotingService		 )
{

 
Task 
< 

AadharCard 
> 
LoadAdharDetails )
() *
long* .
aadharnumber/ ;
); <
;< =
Task 
< 
int 
> 
RegisterVoter 
(  
long  $
aadharnumber% 1
,1 2
string3 9
state: ?
)? @
;@ A
string 
GenerateOtp 
( 
long 
anumber  '
)' (
;( )
SecurityToken 
GenerateJWToken %
(% &
long& *
anumber+ 2
)2 3
;3 4
Task 
< 
List 
< "
ElectionCandidatesList (
>( )
>) *
GetCandiatesList+ ;
(; <
string< B
stateC H
,H I
stringJ P
districtQ Y
)Y Z
;Z [
bool 

SubmitVote 
( 
int 
cid 
,  
string! '
	votetoken( 1
,1 2
long3 7
anumber8 ?
)? @
;@ A
} 
} ƒ
T/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Models/AadharCard.cs
	namespace 	
OnlineVotingApi
 
. 
Models  
{ 
public 

class 

AadharCard 
{ 
[ 	
Key	 
] 
public		 
long		 
AadharNumber		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
public

 
string

 
	FirstName

 
{

  !
get

" %
;

% &
set

' *
;

* +
}

, -
public 
string 
LastName 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
Dob 
{ 
get 
;  
set! $
;$ %
}& '
public 
string 
PhoneNumber !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
Address 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
State 
{ 
get !
;! "
set# &
;& '
}( )
public 
int 
Pincode 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
Gender 
{ 
get "
;" #
set$ '
;' (
}) *
} 
} ©
^/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Models/AssemblyConstituency.cs
	namespace 	
OnlineVotingApi
 
. 
Models  
{ 
public 

class  
AssemblyConstituency %
{ 
[		 	
Key			 
]		 
public

 
int

 
ConstituencyID

 !
{

" #
get

$ '
;

' (
set

) ,
;

, -
}

. /
public 
string 
ConstituencyNmae &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
[ 	

ForeignKey	 
( 
$str  
)  !
]! "
public 
int 

DistrictID 
{ 
get  #
;# $
set% (
;( )
}* +
} 
} ó
\/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Models/DeceasedCandidates.cs
	namespace 	
OnlineVotingApi
 
. 
Models  
{ 
public 

class 
DeceasedCandidates #
{ 
[		 	
Key			 
]		 
public

 
int

 
Id

 
{

 
get

 
;

 
set

  
;

  !
}

" #
public 
string 
DateOfDeath !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	

ForeignKey	 
( 
$str "
)" #
]# $
public 
long 
Aadharnumber  
{! "
get# &
;& '
set( +
;+ ,
}- .
} 
} à
S/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Models/Districts.cs
	namespace 	
OnlineVotingApi
 
. 
Models  
{ 
public 

class 
	Districts 
{ 
[		 	
Key			 
]		 
public

 
int

 

DIstrictID

 
{

 
get

  #
;

# $
set

% (
;

( )
}

* +
public 
string 
DistrictName "
{# $
get% (
;( )
set* -
;- .
}/ 0
[ 	

ForeignKey	 
( 
$str 
) 
]  
public 
int 
StateID 
{ 
get  
;  !
set" %
;% &
}' (
} 
} ≤
`/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Models/ElectionCandidatesList.cs
	namespace 	
OnlineVotingApi
 
. 
Models  
{ 
public 

class "
ElectionCandidatesList '
{ 
[		 	
Key			 
]		 
public

 
int

 
CandidateID

 
{

  
get

! $
;

$ %
set

& )
;

) *
}

+ ,
public 
string 
CandidateName #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

ForeignKey	 
( 
$str $
)$ %
]% &
public 
int !
candidateConstituency (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
} 
} ˝
O/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Models/State.cs
	namespace 	
OnlineVotingApi
 
. 
Models  
{ 
public 

class 
State 
{ 
[		 	
Key			 
]		 
public

 
int

 
StatedID

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
public 
string 
	StateName 
{  !
get" %
;% &
set' *
;* +
}, -
} 
} à
W/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Models/SubmittedVote.cs
	namespace 	
OnlineVotingApi
 
. 
Models  
{ 
public 

class 
SubmittedVote 
{ 
[		 	
Key			 
]		 
public

 
int

 
VoteID

 
{

 
get

 
;

  
set

! $
;

$ %
}

& '
public 
string 
	VoteToken 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

ForeignKey	 
( 
$str !
)! "
]" #
public 
int 
CandID 
{ 
get 
;  
set! $
;$ %
}& '
} 
} œ

O/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Models/Voter.cs
	namespace 	
OnlineVotingApi
 
. 
Models  
{ 
public 

class 
Voter 
{ 
[		 	
Key			 
]		 
public

 
int

 
ID

 
{

 
get

 
;

 
set

  
;

  !
}

" #
public 
string !
Registrationfromstate +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public 
int 
VoterID 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
FName 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

ForeignKey	 
( 
$str "
)" #
]# $
public 
long 
Aadharnumber  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
bool 
Voted 
{ 
get 
;  
set! $
;$ %
}& '
} 
} ß

J/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Program.cs
	namespace

 	
OnlineVotingApi


 
{ 
public 

class 
Program 
{ 
public 
static 
void 
Main 
(  
string  &
[& '
]' (
args) -
)- .
{ 	
CreateHostBuilder 
( 
args "
)" #
.# $
Build$ )
() *
)* +
.+ ,
Run, /
(/ 0
)0 1
;1 2
} 	
public 
static 
IHostBuilder "
CreateHostBuilder# 4
(4 5
string5 ;
[; <
]< =
args> B
)B C
=>D F
Host 
.  
CreateDefaultBuilder %
(% &
args& *
)* +
. $
ConfigureWebHostDefaults )
() *

webBuilder* 4
=>5 7
{ 

webBuilder 
. 

UseStartup )
<) *
Startup* 1
>1 2
(2 3
)3 4
;4 5
} 
) 
; 
} 
} Ïç
^/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Service/OnlineVotingService.cs
	namespace 	
OnlineVotingApi
 
. 
Service !
{ 
public 

class 
OnlineVotingService $
:% & 
IOnlinevotingService' ;
{ 
private 
readonly !
OnlineVotingdbContext .
_context/ 7
;7 8
private 
readonly 
IConfiguration '
_config( /
;/ 0
public 
OnlineVotingService "
(" #!
OnlineVotingdbContext# 8!
onlineVotingdbContext9 N
,N O
IConfigurationO ]
configuration^ k
)k l
{ 	
_context 
= !
onlineVotingdbContext ,
;, -
_config 
= 
configuration #
;# $
} 	
public 
string 
GenerateOtp !
(! "
long" &
anumber' .
). /
{ 	
string 
phonenumber 
=  
string! '
.' (
Empty( -
;- .
try   
{!! 
SqlParameter"" 
	parameter"" &
=""' (
new"") ,
SqlParameter""- 9
(""9 :
$str"": D
,""D E
anumber""F M
)""M N
;""N O
SqlParameter## 
outParameter## )
=##* +
new##, /
SqlParameter##0 <
(##< =
$str##= K
,##K L
System##M S
.##S T
Data##T X
.##X Y
	SqlDbType##Y b
.##b c
VarChar##c j
,##j k
$num##l n
)##n o
;##o p
outParameter$$ 
.$$ 
	Direction$$ &
=$$' (
System$$) /
.$$/ 0
Data$$0 4
.$$4 5
ParameterDirection$$5 G
.$$G H
Output$$H N
;$$N O
string%% 
sql%% 
=%% 
$str%% ]
;%%] ^
var&& 
result&& 
=&& 
_context&& %
.&&% &
Database&&& .
.&&. /
ExecuteSqlRaw&&/ <
(&&< =
sql&&= @
,&&@ A
	parameter&&B K
,&&K L
outParameter&&M Y
)&&Y Z
;&&Z [
return'' 
phonenumber'' "
=''# $
(''% &
string''& ,
)'', -
outParameter''- 9
.''9 :
Value'': ?
;''? @
}++ 
catch,, 
(,, 
	Exception,, 
),, 
{-- 
return.. 
phonenumber.. "
;.." #
}11 
}44 	
public77 
async77 
Task77 
<77 

AadharCard77 $
>77$ %
LoadAdharDetails77& 6
(776 7
long777 ;
aadharnumber77< H
)77H I
{88 	

AadharCard99 

aadharCard99 !
=99" #
new99$ '
(99' (
)99( )
;99) *
try:: 
{;; 
if== 
(== 
_context== 
.== 
DeceasedCandidates== /
.==/ 0
FirstOrDefault==0 >
(==> ?
d==? @
=>==A C
d==D E
.==E F
Aadharnumber==F R
====S U
aadharnumber==V b
)==b c
====d f
null==g k
)==k l
{>> 

aadharCard?? 
=??  
await??! &
_context??' /
.??/ 0

AadharCard??0 :
.??: ;
	FindAsync??; D
(??D E
aadharnumber??E Q
)??Q R
;??R S
}@@ 
returnBB 

aadharCardBB !
;BB! "
}CC 
catchDD 
{EE 
returnFF 

aadharCardFF !
;FF! "
}GG 
}HH 	
publicKK 
asyncKK 
TaskKK 
<KK 
intKK 
>KK 
RegisterVoterKK ,
(KK, -
longKK- 1
anumberKK2 9
,KK9 :
stringKK; A
stateKKB G
)KKG H
{LL 	
VoterMM 
voterMM 
=MM 
newMM 
(MM 
)MM 
;MM  
RandomNN 
randomNN 
=NN 
newNN 
(NN  
)NN  !
;NN! "
intOO 
voterIdOO 
=OO 
randomOO  
.OO  !
NextOO! %
(OO% &
$numOO& .
,OO. /
$numOO0 8
)OO8 9
;OO9 :
varPP 
userNamePP 
=PP 
_contextPP #
.PP# $

AadharCardPP$ .
.PP. /
FirstOrDefaultPP/ =
(PP= >
aPP> ?
=>PP@ B
aPPC D
.PPD E
AadharNumberPPE Q
==PPR T
anumberPPU \
)PP\ ]
.PP] ^
	FirstNamePP^ g
;PPg h
varQQ 
queryQQ 
=QQ 
awaitQQ 
_contextQQ &
.QQ& '
VoterQQ' ,
.QQ, -
FirstOrDefaultAsyncQQ- @
(QQ@ A
vQQA B
=>QQC E
vQQF G
.QQG H
AadharnumberQQH T
==QQU W
anumberQQX _
)QQ_ `
;QQ` a
ifRR 
(RR 
queryRR 
==RR 
nullRR 
)RR 
{TT 
voterUU 
.UU 
AadharnumberUU "
=UU# $
anumberUU% ,
;UU, -
voterVV 
.VV !
RegistrationfromstateVV +
=VV, -
stateVV. 3
;VV3 4
voterWW 
.WW 
VoterIDWW 
=WW 
voterIdWW  '
;WW' (
voterXX 
.XX 
FNameXX 
=XX 
userNameXX &
;XX& '
_contextYY 
.YY 
VoterYY 
.YY 
AddYY "
(YY" #
voterYY# (
)YY( )
;YY) *
if[[ 
([[ 
_context[[ 
.[[ 
SaveChanges[[ (
([[( )
)[[) *
==[[+ -
$num[[. /
)[[/ 0
{\\ 
return^^ 
voterId^^ "
;^^" #
}__ 
}`` 
returnaa 
$numaa 
;aa 
}bb 	
publicee 
SecurityTokenee 
GenerateJWTokenee ,
(ee, -
longee- 1
Anumberee2 9
)ee9 :
{ff 	
vargg 
securityKeygg 
=gg 
newgg ! 
SymmetricSecurityKeygg" 6
(gg6 7
Encodinggg7 ?
.gg? @
UTF8gg@ D
.ggD E
GetBytesggE M
(ggM N
_configggN U
[ggU V
$strggV _
]gg_ `
)gg` a
)gga b
;ggb c
varhh 
tokenHandlerhh 
=hh 
newhh "#
JwtSecurityTokenHandlerhh# :
(hh: ;
)hh; <
;hh< =
tryii 
{jj 
varkk 
namekk 
=kk 
_contextkk #
.kk# $
Voterkk$ )
.kk) *
FirstOrDefaultkk* 8
(kk8 9
vkk9 :
=>kk; =
vkk> ?
.kk? @
Aadharnumberkk@ L
==kkM O
AnumberkkP W
)kkW X
.kkX Y
FNamekkY ^
;kk^ _
varll 
tokenDescriptorll #
=ll$ %
newll& )#
SecurityTokenDescriptorll* A
{mm 
Subjectnn 
=nn 
newnn !
ClaimsIdentitynn" 0
(nn0 1
newnn1 4
Claimnn5 :
[nn: ;
]nn; <
{nn= >
newpp 
Claimpp !
(pp! "
$strpp" 0
,pp0 1
Anumberpp2 9
.pp9 :
ToStringpp: B
(ppB C
)ppC D
)ppD E
,ppE F
newqq 
Claimqq !
(qq! "

ClaimTypesqq" ,
.qq, -
Nameqq- 1
,qq1 2
nameqq3 7
)qq7 8
}rr 
)rr 
,rr 
Expiresss 
=ss 
DateTimess &
.ss& '
UtcNowss' -
.ss- .

AddMinutesss. 8
(ss8 9
$numss9 :
)ss: ;
,ss; <
Issuertt 
=tt 
_configtt $
[tt$ %
$strtt% 1
]tt1 2
,tt2 3
Audienceuu 
=uu 
_configuu &
[uu& '
$struu' 3
]uu3 4
,uu4 5
SigningCredentialsvv &
=vv' (
newvv) ,
SigningCredentialsvv- ?
(vv? @
securityKeyvv@ K
,vvK L
SecurityAlgorithmsvvM _
.vv_ `

HmacSha256vv` j
)vvj k
}ww 
;ww 
SecurityTokenxx 
tokenxx #
=xx$ %
tokenHandlerxx& 2
.xx2 3
CreateTokenxx3 >
(xx> ?
tokenDescriptorxx? N
)xxN O
;xxO P
returnyy 
tokenyy 
;yy 
}zz 
catch{{ 
({{ 
	Exception{{ 
){{ 
{|| 
return}} 
null}} 
;}} 
}~~ 
}
ÄÄ 	
public
ÇÇ 
async
ÇÇ 
Task
ÇÇ 
<
ÇÇ 
List
ÇÇ 
<
ÇÇ $
ElectionCandidatesList
ÇÇ 5
>
ÇÇ5 6
>
ÇÇ6 7
GetCandiatesList
ÇÇ8 H
(
ÇÇH I
string
ÇÇI O
sname
ÇÇP U
,
ÇÇU V
string
ÇÇW ]
district
ÇÇ^ f
)
ÇÇf g
{
ÉÉ 	
List
ÖÖ 
<
ÖÖ $
ElectionCandidatesList
ÖÖ '
>
ÖÖ' ($
electionCandidatesList
ÖÖ) ?
=
ÖÖ@ A
await
ÖÖB G
(
ÖÖH I
from
ÖÖI M
e
ÖÖN O
in
ÖÖP R
_context
ÖÖS [
.
ÖÖ[ \$
ElectionCandidatesList
ÖÖ\ r
join
ÜÜI M
a
ÜÜN O
in
ÜÜP R
_context
ÜÜS [
.
ÜÜ[ \"
Assemblyconstituency
ÜÜ\ p
on
ÜÜq s
e
ÜÜt u
.
ÜÜu v$
candidateConstituencyÜÜv ã
equalsÜÜå í
aÜÜì î
.ÜÜî ï
ConstituencyIDÜÜï £
join
ááI M
d
ááN O
in
ááP R
_context
ááS [
.
áá[ \
	Districts
áá\ e
on
ááf h
a
áái j
.
ááj k

DistrictID
áák u
equals
ááv |
d
áá} ~
.
áá~ 

DIstrictIDáá â
join
ààI M
s
ààN O
in
ààP R
_context
ààS [
.
àà[ \
States
àà\ b
on
ààc e
d
ààf g
.
ààg h
StateID
ààh o
equals
ààp v
s
ààw x
.
ààx y
StatedIDàày Å
where
ââI N
d
ââO P
.
ââP Q
DistrictName
ââQ ]
==
ââ^ `
district
ââa i
&&
ââj l
s
ââm n
.
âân o
	StateName
ââo x
==
âây {
snameââ| Å
select
ääI O
new
ääP S$
ElectionCandidatesList
ääT j
{
ããI J
CandidateID
ååM X
=
ååY Z
e
åå[ \
.
åå\ ]
CandidateID
åå] h
,
ååh i
CandidateName
ççM Z
=
çç[ \
e
çç] ^
.
çç^ _
CandidateName
çç_ l
}
ééI J
)
ééJ K
.
ééK L
ToListAsync
ééL W
(
ééW X
)
ééX Y
;
ééY Z
if
ëë 
(
ëë $
electionCandidatesList
ëë &
!=
ëë' )
null
ëë* .
)
ëë. /
{
íí 
}
ññ 
else
óó 
{
òò 
}
õõ 
return
ûû $
electionCandidatesList
ûû )
;
ûû) *
}
üü 	
public
¢¢ 
bool
¢¢ 

SubmitVote
¢¢ 
(
¢¢ 
int
¢¢ "
cid
¢¢# &
,
¢¢& '
string
¢¢( .
	votetoken
¢¢/ 8
,
¢¢8 9
long
¢¢: >
anumber
¢¢? F
)
¢¢F G
{
££ 	
bool
§§ 
result
§§ 
=
§§ 
false
§§ 
;
§§  
string
•• 
nameFromToken
••  
=
••! "

ValidToken
••# -
(
••- .
	votetoken
••. 7
)
••7 8
;
••8 9
Voter
¶¶ 
userdbDetails
¶¶ 
=
¶¶  !
_context
¶¶" *
.
¶¶* +
Voter
¶¶+ 0
.
¶¶0 1
Where
¶¶1 6
(
¶¶6 7
u
¶¶7 8
=>
¶¶9 ;
u
¶¶< =
.
¶¶= >
FName
¶¶> C
==
¶¶D F
nameFromToken
¶¶G T
)
¶¶T U
.
¶¶U V
Select
¶¶V \
(
¶¶\ ]
n
¶¶] ^
=>
¶¶_ a
new
¶¶b e
Voter
¶¶f k
{
¶¶l m
FName
¶¶n s
=
¶¶t u
n
¶¶v w
.
¶¶w x
FName
¶¶x }
,
¶¶} ~
Voted¶¶ Ñ
=¶¶Ö Ü
n¶¶á à
.¶¶à â
Voted¶¶â é
}¶¶è ê
)¶¶ê ë
.¶¶ë í
FirstOrDefault¶¶í †
(¶¶† °
)¶¶° ¢
;¶¶¢ £
if
ßß 
(
ßß 
userdbDetails
ßß 
.
ßß 
Voted
ßß #
==
ßß$ &
false
ßß' ,
&&
ßß- /
userdbDetails
ßß0 =
.
ßß= >
FName
ßß> C
==
ßßD F
nameFromToken
ßßG T
)
ßßT U
{
®® 
SubmittedVote
©© 
submittedVote
©© +
=
©©, -
new
©©. 1
(
©©1 2
)
©©2 3
;
©©3 4
submittedVote
™™ 
.
™™ 
CandID
™™ $
=
™™% &
cid
™™' *
;
™™* +
submittedVote
´´ 
.
´´ 
	VoteToken
´´ '
=
´´( )
	votetoken
´´* 3
;
´´3 4
_context
¨¨ 
.
¨¨ 
submittedVote
¨¨ &
.
¨¨& '
Add
¨¨' *
(
¨¨* +
submittedVote
¨¨+ 8
)
¨¨8 9
;
¨¨9 :
if
≠≠ 
(
≠≠ 
_context
≠≠ 
.
≠≠ 
SaveChanges
≠≠ (
(
≠≠( )
)
≠≠) *
==
≠≠+ -
$num
≠≠. /
)
≠≠/ 0
{
ÆÆ 
Voter
ØØ 
updateVoter
ØØ %
=
ØØ& '
_context
ØØ( 0
.
ØØ0 1
Voter
ØØ1 6
.
ØØ6 7
Single
ØØ7 =
(
ØØ= >
v
ØØ> ?
=>
ØØ@ B
v
ØØC D
.
ØØD E
FName
ØØE J
==
ØØK M
nameFromToken
ØØN [
)
ØØ[ \
;
ØØ\ ]
updateVoter
∞∞ 
.
∞∞  
Voted
∞∞  %
=
∞∞& '
true
∞∞( ,
;
∞∞, -
if
±± 
(
±± 
_context
±±  
.
±±  !
SaveChanges
±±! ,
(
±±, -
)
±±- .
==
±±/ 1
$num
±±2 3
)
±±3 4
{
≤≤ 
result
≥≥ 
=
≥≥  
true
≥≥! %
;
≥≥% &
}
¥¥ 
}
∑∑ 
}
ππ 
return
∫∫ 
result
∫∫ 
;
∫∫ 
}
ºº 	
public
øø 
string
øø 

ValidToken
øø  
(
øø  !
string
øø! '
	votetoken
øø( 1
)
øø1 2
{
¿¿ 	
string
¡¡ 
name
¡¡ 
=
¡¡ 
string
¡¡  
.
¡¡  !
Empty
¡¡! &
;
¡¡& '
try
¬¬ 
{
√√ %
JwtSecurityTokenHandler
≈≈ '
tokenHandler
≈≈( 4
=
≈≈5 6
new
≈≈7 :%
JwtSecurityTokenHandler
≈≈; R
(
≈≈R S
)
≈≈S T
;
≈≈T U
var
∆∆ 
securityKey
∆∆ 
=
∆∆  !
new
∆∆" %"
SymmetricSecurityKey
∆∆& :
(
∆∆: ;
Encoding
∆∆; C
.
∆∆C D
UTF8
∆∆D H
.
∆∆H I
GetBytes
∆∆I Q
(
∆∆Q R
_config
∆∆R Y
[
∆∆Y Z
$str
∆∆Z c
]
∆∆c d
)
∆∆d e
)
∆∆e f
;
∆∆f g
tokenHandler
«« 
.
«« 
ValidateToken
«« *
(
««* +
	votetoken
««+ 4
,
««4 5
new
««6 9'
TokenValidationParameters
««: S
{
»» &
ValidateIssuerSigningKey
…… ,
=
……- .
true
……/ 3
,
……3 4
ValidateIssuer
   "
=
  # $
true
  % )
,
  ) *
ValidateAudience
ÀÀ $
=
ÀÀ% &
true
ÀÀ' +
,
ÀÀ+ ,
ValidIssuer
ÃÃ 
=
ÃÃ  !
_config
ÃÃ" )
[
ÃÃ) *
$str
ÃÃ* 6
]
ÃÃ6 7
,
ÃÃ7 8
ValidAudience
ÕÕ !
=
ÕÕ" #
_config
ÕÕ$ +
[
ÕÕ+ ,
$str
ÕÕ, 8
]
ÕÕ8 9
,
ÕÕ9 :
IssuerSigningKey
ŒŒ $
=
ŒŒ% &
securityKey
ŒŒ' 2
,
ŒŒ2 3
}
œœ 
,
œœ 
out
œœ 
SecurityToken
œœ $
validatedToken
œœ% 3
)
œœ3 4
;
œœ4 5
var
–– 
securityToken
–– !
=
––" #
tokenHandler
––$ 0
.
––0 1
	ReadToken
––1 :
(
––: ;
	votetoken
––; D
)
––D E
as
––F H
JwtSecurityToken
––I Y
;
––Y Z
name
—— 
=
—— 
securityToken
—— $
.
——$ %
Claims
——% +
.
——+ ,
First
——, 1
(
——1 2
claim
——2 7
=>
——8 :
claim
——; @
.
——@ A
Type
——A E
==
——F H
$str
——I V
)
——V W
.
——W X
Value
——X ]
;
——] ^
return
““ 
name
““ 
;
““ 
}
‘‘ 
catch
’’ 
(
’’ 
	Exception
’’ 
)
’’ 
{
÷÷ 
return
◊◊ 
name
◊◊ 
;
◊◊ 
}
ÿÿ 
}
⁄⁄ 	
}
›› 
}ﬁﬁ ¸/
J/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/Startup.cs
	namespace 	
OnlineVotingApi
 
{ 
public 

class 
Startup 
{ 
public 
Startup 
( 
IConfiguration %
configuration& 3
)3 4
{ 	
Configuration 
= 
configuration )
;) *
} 	
public 
IConfiguration 
Configuration +
{, -
get. 1
;1 2
}3 4
public!! 
void!! 
ConfigureServices!! %
(!!% &
IServiceCollection!!& 8
services!!9 A
)!!A B
{"" 	
services## 
.## 
AddAuthentication## &
(##& '
JwtBearerDefaults##' 8
.##8 9 
AuthenticationScheme##9 M
)##M N
.##N O
AddJwtBearer##O [
(##[ \
options$$ 
=>$$ 
options%% 
.%% %
TokenValidationParameters%% 1
=%%2 3
new%%4 7
	Microsoft%%8 A
.%%A B
IdentityModel%%B O
.%%O P
Tokens%%P V
.%%V W%
TokenValidationParameters%%W p
{&& 
ValidateIssuer'' "
=''# $
true''% )
,'') *
ValidateAudience(( $
=((% &
true((' +
,((+ ,
ValidateLifetime)) $
=))% &
true))' +
,))+ ,$
ValidateIssuerSigningKey** ,
=**- .
true**/ 3
,**3 4
ValidIssuer++ 
=++  !
Configuration++" /
[++/ 0
$str++0 <
]++< =
,++= >
ValidAudience,, !
=,," #
Configuration,,$ 1
[,,1 2
$str,,2 >
],,> ?
,,,? @
IssuerSigningKey-- $
=--% &
new--' * 
SymmetricSecurityKey--+ ?
(--? @
Encoding--@ H
.--H I
UTF8--I M
.--M N
GetBytes--N V
(--V W
Configuration--W d
[--d e
$str--e n
]--n o
)--o p
)--p q
}// 
)// 
;// 
services00 
.00 
AddCors00 
(00 
options00 $
=>00% '
{11 
options22 
.22 
AddDefaultPolicy22 (
(22( )
builder33 
=>33 
{44 
builder55 
.55  
WithOrigins55  +
(55+ ,
$str55, @
,55@ A
$str66, D
,66D E
$str66F u
)66u v
;66v w
}77 
)77 
;77 
}88 
)88 
;88 
services99 
.99 
AddMvc99 
(99 
)99 
;99 
services:: 
.:: 
AddControllers:: #
(::# $
)::$ %
;::% &
services;; 
.;; 
AddDbContext;; !
<;;! "!
OnlineVotingdbContext;;" 7
>;;7 8
(;;8 9
Options;;9 @
=>;;A C
Options;;D K
.;;K L
UseSqlServer;;L X
(;;X Y
Configuration;;Y f
.;;f g
GetConnectionString;;g z
(;;z {
$str	;;{ é
)
;;é è
)
;;è ê
)
;;ê ë
;
;;ë í
services<< 
.<< 
AddTransient<< !
<<<! " 
IOnlinevotingService<<" 6
,<<6 7
OnlineVotingService<<8 K
><<K L
(<<L M
)<<M N
;<<N O
services== 
.== 
AddSwaggerGen== "
(==" #
)==# $
;==$ %
services>> 
.>> 

AddSession>> 
(>>  
)>>  !
;>>! "
}?? 	
publicBB 
voidBB 
	ConfigureBB 
(BB 
IApplicationBuilderBB 1
appBB2 5
,BB5 6
IWebHostEnvironmentBB7 J
envBBK N
)BBN O
{CC 	
ifDD 
(DD 
envDD 
.DD 
IsDevelopmentDD !
(DD! "
)DD" #
)DD# $
{EE 
appFF 
.FF %
UseDeveloperExceptionPageFF -
(FF- .
)FF. /
;FF/ 0
}GG 
elseHH 
{II 
appJJ 
.JJ 
UseExceptionHandlerJJ '
(JJ' (
$strJJ( 0
)JJ0 1
;JJ1 2
appLL 
.LL 
UseHstsLL 
(LL 
)LL 
;LL 
}MM 
appOO 
.OO 

UseSwaggerOO 
(OO 
)OO 
;OO 
appPP 
.PP 
UseSwaggerUIPP 
(PP 
cPP 
=>PP !
{QQ 
cRR 
.RR 
SwaggerEndpointRR !
(RR! "
$strRR" <
,RR< =
$strRR> L
)RRL M
;RRM N
}SS 
)SS 
;SS 
appUU 
.UU 
UseHttpsRedirectionUU #
(UU# $
)UU$ %
;UU% &
appVV 
.VV 
UseStaticFilesVV 
(VV 
)VV  
;VV  !
appXX 
.XX 

UseRoutingXX 
(XX 
)XX 
;XX 
appYY 
.YY 
UseCorsYY 
(YY 
)YY 
;YY 
appZZ 
.ZZ 
UseAuthenticationZZ !
(ZZ! "
)ZZ" #
;ZZ# $
app[[ 
.[[ 
UseAuthorization[[  
([[  !
)[[! "
;[[" #
app\\ 
.\\ 

UseSession\\ 
(\\ 
)\\ 
;\\ 
app^^ 
.^^ 
UseEndpoints^^ 
(^^ 
	endpoints^^ &
=>^^' )
{__ 
	endpoints`` 
.`` 
MapControllers`` (
(``( )
)``) *
;``* +
}aa 
)aa 
;aa 
}bb 	
}cc 
}dd €
R/Users/vijendrakondeti/Projects/OnlineVotingApi/OnlineVotingApi/WeatherForecast.cs
	namespace 	
OnlineVotingApi
 
{ 
public 

class 
WeatherForecast  
{ 
public 
DateTime 
Date 
{ 
get "
;" #
set$ '
;' (
}) *
public		 
int		 
TemperatureC		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
public 
int 
TemperatureF 
=>  "
$num# %
+& '
(( )
int) ,
), -
(- .
TemperatureC. :
/; <
$num= C
)C D
;D E
public 
string 
Summary 
{ 
get  #
;# $
set% (
;( )
}* +
} 
} 