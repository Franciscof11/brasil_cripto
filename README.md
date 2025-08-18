# 🚀 BrasilCripto

App Flutter para acompanhar criptomoedas com busca local inteligente e modo escuro/claro.

## 📱 Features

- **🔍 Busca Local**: Sistema inteligente sem rate limits da API
- **🌙 Modo Escuro/Claro**: Toggle instantâneo com persistência
- **⭐ Favoritos**: Sistema de favoritos com armazenamento local
- **📊 Detalhes**: Preços, gráficos e estatísticas completas
- **🎨 Design**: Interface moderna com tema customizado
- **⚡ Performance**: Cache local e otimizações de UX

## 🏗️ Arquitetura

**MVVM + Provider** para gerenciamento de estado reativo com separação clara entre Models, Views e ViewModels.

## 🛠️ Stack

- **Flutter** + **Provider** para gerenciamento de estado
- **Hive** para persistência local (favoritos, tema)
- **CoinGecko API** para dados de criptomoedas
- **FL Chart** para gráficos interativos

## 🚀 Executar

```bash
git clone https://github.com/seu-usuario/brasil_cripto.git
cd brasil_cripto
flutter pub get
dart run build_runner build
flutter run
```

## 📦 Download APK

APK pronto para instalação disponível em: **`release/apk/brasil-cripto-v1.0.1.apk`** (~22MB)

## 🎯 Destaques

- **Busca Local**: Elimina rate limits da API com cache inteligente
- **Modo Escuro/Claro**: Interface adaptativa com tema customizado
- **Performance**: Debounce de 200ms e otimizações de UX
- **Favoritos**: Persistência local com Hive

## 📁 Estrutura

```
lib/
├── core/           # Constantes, storage, temas
├── models/         # Cryptocurrency model
├── services/       # API e persistência
├── viewmodels/     # Controllers (Provider)
└── views/          # Pages e widgets
```

---

**Desenvolvido com ❤️ usando Flutter**
