    🎯 Propósito do Projeto
    
O Guard-Cost é uma solução de controle automático de custos da AWS que atua como um "guarda" dos seus gastos na nuvem. O projeto foi criado para evitar surpresas na fatura da AWS.

    🔍 Como Funciona

O sistema funciona da seguinte forma:

1. Monitoramento: Usa o AWS Budgets para monitorar gastos em tempo real
2. Limite: Define um limite muito baixo de custo (US$ 0,01)
3. Alerta: Quando o custo passa desse limite, dispara uma notificação via SNS
4. Ação Automática: Executa uma função Lambda que desliga automaticamente os recursos da AWS (como instâncias EC2)

    🛠️ Tecnologias Utilizadas

-Terraform (84.6% do código): Infraestrutura como código para provisionar todos os recursos
-AWS Lambda com Python (15.4% do código): Função que executa o desligamento dos recursos
-AWS Budgets: Para monitoramento de custos
-AWS SNS: Para notificações e alertas
-GitHub Actions: Para automação de deploy (CI/CD)

    ✅ Funcionalidades Atuais

✅ Criação automática de orçamento com alertas
✅ Notificações quando o limite é atingido
✅ Execução de Lambda para interromper recursos definidos

    🔮 Próximos Passos (Planejados)

-Suporte a múltiplos tipos de recursos (EC2, RDS, ECS, DocumentDB)
-Customização de recursos via variáveis do Terraform
-Melhorias no monitoramento e relatórios

    💡 Casos de Uso

Este projeto é ideal para:

-Estudantes aprendendo AWS que querem evitar gastos acidentais
-Desenvolvedores testando recursos em contas pessoais
-Empresas que querem um controle rigoroso de custos em ambientes de desenvolvimento
-Projetos POC onde o orçamento é muito limitado