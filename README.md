# 🚀 BrasilCripto

Um aplicativo Flutter moderno para acompanhar e gerenciar criptomoedas, desenvolvido seguindo as melhores práticas de Clean Architecture e padrões de design.

## 📱 Sobre o Projeto

BrasilCripto é um aplicativo que permite aos usuários:

- **🔍 Pesquisar Criptomoedas**: Busque por nome ou símbolo para encontrar informações detalhadas
- **⭐ Favoritos**: Salve suas criptomoedas preferidas para acesso rápido
- **📊 Detalhes Completos**: Visualize informações detalhadas incluindo preços, gráficos e estatísticas de mercado
- **💾 Persistência Local**: Dados de favoritos salvos localmente mesmo após fechar o app
- **🔄 Atualizações em Tempo Real**: Dados sempre atualizados através da API CoinGecko

## 🏗️ Arquitetura

O projeto foi desenvolvido seguindo os princípios de **Clean Architecture** dividido em três camadas principais:

### 📋 Domain Layer (Camada de Domínio)
- **Entities**: Modelos de negócio puros (`Cryptocurrency`)
- **Repositories**: Interfaces que definem contratos de dados
- **Use Cases**: Lógica de negócio específica (pesquisar, favoritar, obter detalhes)

### 💾 Data Layer (Camada de Dados)
- **Models**: Implementações concretas das entidades com serialização
- **Data Sources**: Fontes de dados (API remota e armazenamento local)
- **Repository Implementations**: Implementações concretas dos contratos de repositório

### 🎨 Presentation Layer (Camada de Apresentação)
- **Pages**: Telas do aplicativo
- **Widgets**: Componentes reutilizáveis da UI
- **Cubits**: Gerenciamento de estado usando padrão BLoC
- **States**: Estados da aplicação

## 🛠️ Tecnologias e Packages Utilizados

### **Core Framework**
- **Flutter**: Framework multiplataforma para desenvolvimento mobile
- **Dart**: Linguagem de programação

### **Gerenciamento de Estado**
- **flutter_bloc (^8.1.3)**: Implementação do padrão BLoC para gerenciamento de estado reativo
- **equatable (^2.0.5)**: Facilita comparação de objetos e estados

### **Requisições HTTP**
- **http (^1.1.0)**: Cliente HTTP para comunicação com APIs REST
- **dio (^5.3.2)**: Cliente HTTP avançado com interceptors e logging

### **Armazenamento Local**
- **hive (^2.2.3)**: Banco de dados NoSQL local rápido e leve
- **hive_flutter (^1.1.0)**: Integração do Hive com Flutter
- **hive_generator (^2.0.1)**: Gerador de código para adapters do Hive

### **Interface do Usuário**
- **cached_network_image (^3.3.0)**: Cache inteligente de imagens da rede
- **fl_chart (^0.64.0)**: Biblioteca para criação de gráficos e charts
- **shimmer (^3.0.0)**: Efeito de carregamento elegante

### **Utilitários**
- **intl (^0.18.1)**: Internacionalização e formatação de datas/números
- **dartz (^0.10.1)**: Programação funcional com Either para tratamento de erros
- **get_it (^7.6.4)**: Injeção de dependência (Service Locator)

### **Desenvolvimento**
- **build_runner (^2.4.7)**: Ferramenta para geração de código
- **flutter_lints (^5.0.0)**: Regras de lint para código Dart/Flutter limpo

## 🔧 Como Executar

### Pré-requisitos
- Flutter SDK (versão 3.8.1 ou superior)
- Dart SDK
- Android Studio ou VS Code
- Dispositivo Android/iOS ou emulador

### Passos para Instalação

1. **Clone o repositório**
   ```bash
   git clone https://github.com/seu-usuario/brasil_cripto.git
   cd brasil_cripto
   ```

2. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Gere os arquivos necessários**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Execute o aplicativo**
   ```bash
   flutter run
   ```

### Gerar APK
```bash
# APK de Debug
flutter build apk --debug

# APK de Release
flutter build apk --release
```

## 📊 API Utilizada

**CoinGecko API**: API gratuita e confiável para dados de criptomoedas
- **Base URL**: `https://api.coingecko.com/api/v3`
- **Endpoints utilizados**:
  - `/coins/markets` - Lista de criptomoedas com dados de mercado
  - `/search` - Busca por criptomoedas
  - `/coins/{id}` - Detalhes específicos de uma criptomoeda

## 🎯 Funcionalidades Implementadas

### ✅ Funcionalidades Principais
- [x] Listagem de top criptomoedas
- [x] Busca por nome ou símbolo
- [x] Adicionar/remover favoritos
- [x] Visualização de detalhes completos
- [x] Persistência local de favoritos
- [x] Interface responsiva e moderna
- [x] Tratamento de erros e estados de loading
- [x] Pull-to-refresh
- [x] Navegação intuitiva

### 🎨 Interface
- Design moderno com Material Design
- Animações e transições suaves
- Shimmer loading effects
- Cards com elevação e bordas arredondadas
- Cores condicionais para variações de preço
- Ícones intuitivos e consistentes

## 📁 Estrutura do Projeto

```
lib/
├── core/
│   ├── constants/          # Constantes da aplicação
│   ├── di/                 # Injeção de dependência
│   ├── errors/             # Tratamento de erros
│   └── storage/            # Configuração do Hive
├── features/
│   └── cryptocurrency/
│       ├── data/
│       │   ├── datasources/    # Fontes de dados
│       │   ├── models/         # Modelos de dados
│       │   └── repositories/   # Implementações de repositório
│       ├── domain/
│       │   ├── entities/       # Entidades de negócio
│       │   ├── repositories/   # Interfaces de repositório
│       │   └── usecases/       # Casos de uso
│       └── presentation/
│           ├── cubit/          # Gerenciamento de estado
│           ├── pages/          # Telas da aplicação
│           └── widgets/        # Componentes reutilizáveis
└── main.dart               # Ponto de entrada da aplicação
```

## 🧪 Princípios Aplicados

- **SOLID**: Princípios de design orientado a objetos
- **DRY**: Don't Repeat Yourself
- **KISS**: Keep It Simple, Stupid
- **Clean Architecture**: Separação clara de responsabilidades
- **Dependency Injection**: Inversão de controle e dependências
- **Error Handling**: Tratamento robusto de erros com Either pattern

## 🚀 Próximos Passos

- [ ] Implementar testes unitários e de widget
- [ ] Adicionar mais tipos de gráficos
- [ ] Sistema de notificações para alertas de preço
- [ ] Modo escuro
- [ ] Suporte a múltiplas moedas (EUR, BRL, etc.)
- [ ] Cache offline de dados

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

Desenvolvido com ❤️ usando Flutter
