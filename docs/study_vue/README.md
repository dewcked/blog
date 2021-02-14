# Introduction

학부 생활을 마치고 보니 본인의 실력이 형편없었다. 그래서 깃허브를 정비하며 문서를 다시 쌓아나가기 위해 블로그를 재구축하기로 결정했다. 개발을 하면서 동시에 블로그도 같이 관리하기 편한 곳은 Github-Pages 라고 생각하기 때문에 과거에 만들었던 Jekyll(Ruby 기반) 블로그는 일단 남겨둔 채 새로 블로그를 만들어보기로 했다.

Github-Pages 는 SSG(Static Site Generator)를 이용해 블로그처럼 사용할 수 있는 플랫폼이다. SSG는 말 그대로 정적 사이트를 만들어 주는 도구이다. [잼스택](https://jamstack.org/generators/ )에서 다양한 SSG를 볼 수 있다. 본인의 언어(python, go, ruby, javascript, typescript), 프레임워크(jekyll, react, vue, angularjs)에 따라 선택할 수 있다. 각 플랫폼, 언어마다 장단점이 있지만 개인적으로 편리하다고 생각되는 Vuepress를 선택했다.

블로그 구축은 굵고 짧게 세 단계로 개발 환경 만들기, 배포(deploy) 하기, 블로그 환경 꾸미기로 나누었다.