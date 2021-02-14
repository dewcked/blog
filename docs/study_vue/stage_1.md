# Stage 1 개발 환경 만들기

개발 환경은 Windows + Visual Studio Code + Git + Github 로 결정했다. Linux에서 개발해도 딱히 문제는 없지만 Visual Studio Code 도구를 익힐 겸 Windows에서 진행했다.

아래는 [VuePress 홈페이지](https://vuepress.vuejs.org/) 안의 [가이드](https://vuepress.vuejs.org/guide/getting-started.html)를 일부 번역 + 입맛에 맞게 추가 및 수정했다.

[블로그 구축에 큰 도움을 주신 분](https://kyounghwan01.github.io)

## 프로그램 설치

### Prerequisities(전제조건)

[Node.js 10+](https://nodejs.org/en/)<sup>*다운로드 링크</sup>

Node.js 모듈을 내려받으려면 NPM 또는 [Yarn](https://classic.yarnpkg.com/en/)<sup>*다운로드 링크</sup>이 필요한데, NPM은 Node.js를 받으면 내장되어 있는 기본 [패키지 관리자](https://ko.wikipedia.org/wiki/%ED%8C%A8%ED%82%A4%EC%A7%80_%EA%B4%80%EB%A6%AC%EC%9E%90)이다. webpack 3.x 버전을 사용중인 경우 NPM 쓸 때 설치 문제가 발생한다고 하지만 아직 문제를 찾지 못했기에 그냥 Node.js 만 설치했다.

```
설치 확인 방법(cmd)
node -v
npm -v
```

### [GIT](https://git-scm.com/downloads)<sup>*다운로드 링크</sup>

버전 관리를 위해 필요한 프로그램

```
설치 확인 방법(cmd)
git --version
```

### [Visual Studio Code](https://code.visualstudio.com/)<sup>*다운로드 링크</sup>

편리한 소스 코드 작성 및 용이한 버전 관리를 위해 필요한 프로그램

## 기본 프로그램 작성

### Vuepress 작성

1. 윈도우 탐색기 창(Explorer.exe)을 하나 열어 주소에 `%username%`을 입력한 후 디렉토리를 하나 만든다.

2. Visual Studio Code 상단 메뉴의 `File - Open Folder` 선택 후 주소에 `%username%` 입력, 만든 디렉토리를 클릭하고 폴더를 선택하면 해당 폴더가 디렉토리에 열린다.

3. 상단 메뉴에서 `Terminal - New Terminal` 을 선택하면 하단에 cmd같은 터미널이 열린다.

4. 터미널에서 `npx create-vuepress-site` 를 입력하면 기본 정보 입력 후 VuePress 기본 템플릿 파일들이 받아진다. (Project Name, Description, Maintainer Email. Maintainer Name, Repository URL을 요구한다. Project Name은 github에 만들 repository 이름, Description은 설명 아무거나, Maintainer Email은 이메일, Maintainer Name은 이름, Repository URL에는 본인 github 주소<sup>*https://github.com/<id를 여기에></sup>를 작성하면 된다. 

5. 폴더 구조가 docs > src 로 되어 있을 텐데 편의를 위해 src를 docs로 바꾼다. 바깥 docs 폴더는 없애도 무방하다.

6. package.json 파일 내의 scripts 부분을 다음과 같이 바꾼다.

   ```json
   "scripts": {
       "docs:dev": "vuepress dev docs",
       "docs:build": "vuepress build docs"
     },
   ```

7. 터미널을 켠 후 package.json이 있는 경로에서 터미널에 명령어를 입력한다.

   ```
   npm install
   npm run docs:dev
   ```

8. 성공했다면 아래에 로컬에서 구동된 VuePress를 볼 수 있는 [주소](http://localhost:8080/)<sup>*localhost:8080</sup>가 뜬다. 블로그가 로컬 환경에서 정상적으로 실행된 것을 볼 수 있다.

## 보충설명

package.json은 각종 npm 패키지들을 관리함과 동시에 빌드 모드와 개발 모드를 분리할 수 있게 도와준다. `npm install`은 초기에 한 번 노드 모듈들(node_modules)을 다운로드받는 데 필요하다. `npm run docs:dev`의 경우 개발 모드에서 결과를 확인할 때, `npm run docs:build`의 경우 빌드로 Static Site를 만들 때 쓰는 명령어다. 미리 빌드하면 귀찮아지므로 Stage 2 문서로 넘어가자.

