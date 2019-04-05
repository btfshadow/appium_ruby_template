# language: pt
Funcionalidade: Sample bitBar

Contexto: Estar com o app aberto
Dado que o app esteja aberto

Cenário: Devo receber uma mensagem de sucesso caso responda para usar o TestDroid Cloud
Quando Escolher a opção "TestDroid Cloud"
E escrevo o meu nome
Então Vejo a tela de sucesso

Cenário: Devo receber uma mensagem de falha caso responda para comprar 101 devices
Quando Escolher a opção "Buy 101 devices"
E escrevo o meu nome
Então Vejo a tela de falha
