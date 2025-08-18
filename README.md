# 🚀 BrasilCripto

Um aplicativo Flutter moderno e elegante para acompanhar criptomoedas, com interface adaptativa para modo claro/escuro e busca inteligente local.

## 📱 Sobre o Projeto

BrasilCripto é um aplicativo completo que oferece:

- **🔍 Busca Inteligente**: Sistema de busca local com debounce e ordenação por relevância (nome, símbolo, ranking)
- **🌙 Modo Escuro/Claro**: Interface adaptativa com toggle instantâneo e persistência de preferência
- **⭐ Sistema de Favoritos**: Salve suas criptomoedas preferidas com persistência local via Hive
- **📊 Detalhes Completos**: Visualize preços, gráficos, market cap, volume e estatísticas detalhadas
- **🎨 Design Moderno**: Interface com cores customizadas (roxo + amarelo queimado) e Material 3
- **⚡ Performance Otimizada**: Cache local inteligente que elimina requisições desnecessárias à API
- **🔄 Pull-to-Refresh**: Atualize dados com gesto intuitivo

## 🏗️ Arquitetura

O projeto utiliza **arquitetura MVVM (Model-View-ViewModel)** com Provider para gerenciamento de estado:

### 📋 Models (Modelos)
- **Cryptocurrency**: Entidade principal com serialização JSON
- **Theme Models**: Configuração de temas claro/escuro

### 🎛️ ViewModels (Controladores)
- **CryptocurrencyViewModel**: Gerencia lista e busca local
- **FavoritesViewModel**: Controla sistema de favoritos
- **CryptocurrencyDetailsViewModel**: Manipula detalhes de moedas
- **ThemeProvider**: Gerencia estado do tema

### 🔧 Services (Serviços)
- **CryptocurrencyService**: Comunicação com API CoinGecko
- **FavoritesService**: Persistência local com Hive
- **HiveStorage**: Configuração de armazenamento local

### 🎨 Views (Interface)
- **Pages**: Telas principais (Lista, Detalhes, Favoritos)
- **Widgets**: Componentes reutilizáveis temáticos

## 🛠️ Tecnologias e Packages

### **Core Framework**
- **Flutter**: Framework multiplataforma para desenvolvimento mobile
- **Dart**: Linguagem de programação

### **Gerenciamento de Estado**
- **provider (^6.1.1)**: Padrão Provider para gerenciamento de estado reativo
- **equatable (^2.0.5)**: Facilita comparação de objetos e estados

### **Requisições HTTP**
- **http (^1.1.0)**: Cliente HTTP para comunicação com CoinGecko API

### **Armazenamento Local**
- **hive (^2.2.3)**: Banco de dados NoSQL local para favoritos e preferências
- **hive_flutter (^1.1.0)**: Integração do Hive com Flutter
- **hive_generator (^2.0.1)**: Gerador de código para adapters

### **Interface do Usuário**
- **cached_network_image (^3.3.0)**: Cache inteligente de ícones das criptomoedas
- **fl_chart (^0.64.0)**: Gráficos de preço interativos
- **shimmer (^3.0.0)**: Efeito de loading elegante durante carregamento

### **Utilitários**
- **intl (^0.18.1)**: Formatação de valores monetários e datas

### **Desenvolvimento**
- **build_runner (^2.4.7)**: Geração de código para Hive adapters
- **flutter_lints (^5.0.0)**: Regras de lint para código limpo

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

3. **Gere os arquivos do Hive**
   ```bash
   dart run build_runner build
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
  - `/coins/markets` - Lista de top 100 criptomoedas com dados de mercado
  - `/coins/{id}` - Detalhes específicos de uma criptomoeda

> **Nota**: A busca agora é 100% local para evitar rate limits e melhorar performance

## ✨ Funcionalidades Implementadas

### 🚀 Core Features
- [x] **Listagem de Top 100 Criptomoedas** com dados em tempo real
- [x] **Busca Local Inteligente** com debounce e ordenação por relevância
- [x] **Sistema de Favoritos** com persistência local via Hive
- [x] **Página de Detalhes** completa com gráficos e estatísticas
- [x] **Pull-to-Refresh** para atualização manual dos dados
- [x] **Navegação Intuitiva** com bottom navigation

### 🎨 Design System
- [x] **Modo Claro/Escuro** com toggle instantâneo
- [x] **Tema Customizado** (roxo + amarelo queimado + preto)
- [x] **Material 3** com componentes modernos
- [x] **Interface Adaptativa** que responde ao tema do sistema
- [x] **Shimmer Loading** durante carregamentos
- [x] **Cards Temáticos** com elevação e bordas arredondadas

### ⚡ Performance & UX
- [x] **Cache Local** elimina requisições desnecessárias à API
- [x] **Debounce na Busca** (200ms) para melhor performance
- [x] **Estados de Loading** claros e informativos
- [x] **Tratamento de Erros** robusto com retry
- [x] **Persistência de Preferências** (tema, favoritos)

### 🔍 Sistema de Busca Avançado
- [x] **Busca por Nome**: "bitcoin", "ethereum"
- [x] **Busca por Símbolo**: "btc", "eth", "sol"
- [x] **Busca por Ranking**: "1" (Bitcoin), "2" (Ethereum)
- [x] **Ordenação Inteligente**: matches exatos primeiro, depois parciais
- [x] **Case-Insensitive**: "BITCOIN" = "bitcoin" = "Bitcoin"

## 📁 Estrutura do Projeto

```
lib/
├── core/
│   ├── constants/          # Constantes da API
│   ├── storage/            # Configuração do Hive
│   └── theme/              # Sistema de temas (claro/escuro)
├── models/                 # Modelos de dados (Cryptocurrency)
├── services/               # Serviços de API e persistência
├── viewmodels/             # ViewModels (Provider controllers)
├── views/
│   ├── pages/              # Telas principais
│   └── widgets/            # Componentes reutilizáveis
└── main.dart               # Configuração da aplicação
```

### 🗂️ Principais Arquivos
- **`main.dart`**: Configuração de providers e temas
- **`core/theme/`**: Sistema completo de temas claro/escuro
- **`models/cryptocurrency.dart`**: Modelo principal com Hive adapter
- **`services/cryptocurrency_service.dart`**: Comunicação com CoinGecko API
- **`viewmodels/cryptocurrency_viewmodel.dart`**: Lógica de busca local inteligente
- **`views/pages/`**: Telas de lista, detalhes e favoritos

## 🧪 Princípios Aplicados

- **MVVM Pattern**: Separação clara entre lógica e interface
- **Provider Pattern**: Gerenciamento de estado reativo e eficiente
- **Local-First**: Cache local inteligente reduz dependência da API
- **Responsive Design**: Interface adaptativa para diferentes temas
- **Performance**: Debounce, cache e otimizações para melhor UX
- **Error Handling**: Tratamento robusto de erros com retry mechanisms

## 🎯 Destaques Técnicos

### 🔍 **Busca Local Inteligente**
O sistema de busca foi otimizado para eliminar o erro "too many requests":
- **Cache Local**: Busca nas 100 top criptomoedas já carregadas
- **Algoritmo de Relevância**: Prioriza matches exatos e começando com a query
- **Debounce**: 200ms para evitar buscas desnecessárias
- **Zero API Calls**: Busca instantânea sem limitações

### 🌙 **Sistema de Temas Avançado**
- **Persistência**: Preferência salva automaticamente
- **Cores Customizadas**: Paleta única (roxo + amarelo queimado)
- **Adaptação Completa**: Todos os componentes respondem ao tema
- **Toggle Instantâneo**: Mudança sem delays ou recarregamentos

### ⚡ **Performance Otimizada**
- **Cache de Imagens**: Ícones das criptomoedas são cacheados
- **Lazy Loading**: Carregamento eficiente de listas
- **Estado Local**: Menos requisições = maior velocidade

## 🚀 Próximas Melhorias

- [ ] Testes unitários e de integração
- [ ] Notificações push para alertas de preço
- [ ] Suporte a múltiplas moedas (BRL, EUR)
- [ ] Gráficos mais avançados (1h, 7d, 1m, 1y)
- [ ] Cache offline com sincronização
- [ ] Filtros avançados (por market cap, volume, variação)

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 🎖️ Status do Projeto

**Versão Atual**: v1.0.0  
**Status**: ✅ Completo e Funcional  
**Última Atualização**: Dezembro 2024

### 📊 Métricas
- **Criptomoedas Suportadas**: Top 100 do CoinGecko
- **Performance de Busca**: < 200ms (local)
- **Cache Local**: Hive para persistência
- **Temas**: 2 (Claro + Escuro)
- **Plataformas**: Android + iOS

---

**Desenvolvido com ❤️ usando Flutter**

*Um projeto demonstrando boas práticas em desenvolvimento mobile com foco em performance, UX e design moderno.*
