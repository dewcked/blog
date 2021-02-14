# Stage 2 배포(deploy)하기

## Github 연동하기

### Github repository 생성 및 Sync

1. Github repository를 만든다. 이 때 위에서 입력한 repository와 같은 이름으로 만든다.
2. Visual Studio Code의 좌측 세 번째 나무줄기 같은 모양 메뉴에서`Initialize Repository`를 클릭한다. 로컬 저장소가 생성되면서 Git을 사용해 Github와 연동할 수 있는 편리한 도구가 열린다.
3. `SOURCE CONTROL REPOSITORIES` 맨 오른쪽의 ···을 클릭, `Remote - Add Remote` 메뉴를 선택하면 상단에 Add remote from Github 메뉴가 새로 뜬다. 클릭 후 일련의 과정을 따라가면 저장소를 쉽게 연결할 수 있다. 이제 당신은 원격 repository가 연결된 상태이다. 여기서 마지막에 원격 repository 이름을 정하는 과정이 있는데 무난하게 origin으로 하면 편리하다. 다른 것으로 했을 경우 기억하고 있는 것이 좋다.
4. `SOURCE CONTROL REPOSITORIES` 맨 오른쪽의 ···을 클릭, `Pull, Push - Sync`를 누르면 원격 repository와 동기화된다.

### .gitignore 작성

`package.json`이 있는 폴더에 `.gitignore` 파일을 작성한다. 파일은 VS CODE의 Explorer에서 폴더 또는 빈곳 우클릭으로 만들 수 있다.

```
node_modules
package-lock.json
.npmignore
deploy.bat
```

.gitignore를 모르는 사람들은 없겠지만 여기에 작성된 파일이나 폴더는 원격 repository에 올라갈 때 제외된다. 위 목록에 대해 부연설명을 하면 `node_modules`는 빌드 및 실행에 필요한 파일들로 `repository`에 들어갈 필요가 없는 파일들이다. `package-lock.json`도 `node_modules`와 마찬가지로 npm install에 의해 생겨난 부산물이다. `.npmignore`도 필요 없으므로 제외, `deploy.bat`은 윈도우에서 빌드 및 배포를 한 번에 편리하게 하기 위해 만들 배치 파일이다.

### .gitmodules 작성

`.gitmodules`는 git의 submodule을 관리하기 위한 파일이다. submodule 기능은 내 저장소가 다른 저장소의 파일이나 폴더를 필요로 하지만, 내 저장소에 넣기는 애매할 때 주로 사용한다. build를 하면 알게 되지만, build로 생성되는 결과물은 docs\\.vuepress\\dist 위치에 저장된다. 다시 말해, 블로그를 구성하는 실질적인 Static Site들은 이 dist 폴더 안에 생성된다.

Github Pages에 올린 블로그에 접속하려면 구체적인 링크를 제시해줘야 하는데 블로그가 dist 폴더 안에 있으므로 링크 주소가 번잡해지게 되는 단점이 있다. 그리고 빌드 파일과 소스 파일의 구분이 제대로 되지 않는다는 단점도 있다. 빌드 결과물을 다른 repository에 저장하기도 애매하다. 그래서 사람들은 gh-pages라는 branch를 만들고 submodule을 이용해 소스 파일은 master branch에서, 빌드 파일은 gh-pages branch에서 관리하는 방법을 사용하고 있다.

`package.json`이 있는 경로에 `.gitmodules`를 다음과 같이 작성한다. `본인 github id`, `repository`는 본인 것으로 작성해야 한다.

```
[submodule "docs/.vuepress/dist"]
	path = docs/.vuepress/dist
	url = git@github.com:<본인 github id>/<repository>.git
```

### LICENSE 작성<sup>*Optional</sup>

깃허브 저장소를 만들 때 생성했으면 상관없지만 아무래도 만들어 두는 것이 좋다.

아래는 대표적인 mit 라이센스 파일 `LICENSE` 전문이다.

```
MIT License

Copyright (c) 2021 <사용자 이름>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### deploy.bat 작성

submodule 디렉토리 구조는 꽤 복잡해서 손이 많이 가기 때문에 `deploy.bat`은 Windows에서 스크립트 하나로 빌드 및 배포를 자동화하기 위한 배치 파일이다.

```
pushd "%~dp0"

call git pull
call git add -A
call git commit -m "dev commit"
call git push origin master

call npm run docs:build
cd docs\.vuepress\dist

call git init
call git add -A
call git commit -m "deploy with vuepress"
call git push -f git@github.com:dewcked/blog.git master:gh-pages

popd 

call git pull
call git add -A
call git commit -m "dist changes"
call git push origin master
```

첫 번째 줄은 현재 디렉토리 경로를 저장한다.

그 다음은 원격 repository를 pull 한 후 새로 추가한 내용을 commit 후 push한다. (만약 원격 저장소를 origin이 아닌 blog라던가 다른 이름으로 지정했을 경우 origin을 그것으로 바꿔야 한다.)

세 번째 블록은 빌드한 후 dist 폴더로 이동한다.

네 번째 블록은 빌드 한 위치에서 새로운 임시 repository를 만들어 원격 repository의 gh-pages branch로 push한다.

popd를 통해 이전 디렉토리 경로로 돌아오고, 마지막으로 dist submodule의 위치를 동기화해준다. (여기서도 마찬가지로 원격 저장소 이름을 다른 이름으로 지정했을 경우 origin을 그것으로 바꿔야 한다.)

리눅스를 위한 `deploy.sh`는 Stage 1의 도움 받은 분 링크에 있다..

### Github 접근 권한 발급받기

Github 저장소에 대한 접근 권한을 얻기 위해 ssh 공개키를 생성해서 본인의 github 계정에 등록하면 권한 관련 오류에서 자유롭기 때문에 필수적이다.

ssh 공개키 생성 및 본인 계정에 등록하는 것은 [다른](https://syung05.tistory.com/20) [블로그](https://infinitt.tistory.com/316)에 [잘](https://rfriend.tistory.com/603) [설명이](https://nickjoit.tistory.com/94) [되어](https://git-scm.com/book/ko/v2/Git-%EC%84%9C%EB%B2%84-SSH-%EA%B3%B5%EA%B0%9C%ED%82%A4-%EB%A7%8C%EB%93%A4%EA%B8%B0) [있다](https://opentutorials.org/module/4627/27804).

### config.js 설정

Stage 1 과정을 잘 따라왔다면 `.vuepress` 안에 `config.js`가 생성되어 있다. `module exports = {` 안에 title, description 등이 나열되어 있는 것을 볼 수 있는 데 중간에 쉼표(,) 하나 넣고 다음 내용을 추가한다.

```
base: "/<repository>/"
```

`repository`는 본인 것으로 작성해야 한다.

### Build

마지막 단계인 build 단계이다. 터미널을 실행해서 `deploy.bat`이 있는 위치로 간 뒤 다음과 같이 입력하면 된다.

```
.\deploy.bat
```

자동으로 커밋 및 빌드가 진행되고 원격 repository에 새로운 브랜치가 생성되면서 저장된다. 만약 원격 repository에 저장되지 않으면 Sync 상태나 Github 접근 권한 상태(ssh 공개키 등록 여부)를 확인해본다.

## Github Pages 주소 설정하기

블로그가 있는 repository에서 `Setting` 메뉴에 들어간 다음 아래로 쭉 내리면 `Github Pages` 탭을 볼 수 있다. Branch에서 gh-pages, /root 를 선택한 다음 Save 하고 조금 기다리면 블로그가 완성되면서 다음과 같은 메세지가 뜨면 성공이다.

```
Your site is published at ~~~~~~~~~~
```

