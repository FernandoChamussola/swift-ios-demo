
import SwiftUI

private enum CQ {
    static let bg = Color(red: 0.035, green: 0.055, blue: 0.09)
    static let panel = Color(red: 0.075, green: 0.10, blue: 0.15)
    static let green = Color(red: 0.25, green: 0.95, blue: 0.60)
    static let blue = Color(red: 0.30, green: 0.65, blue: 1.0)
    static let muted = Color(red: 0.58, green: 0.65, blue: 0.75)
}

private struct Lesson: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let icon: String
    let concept: String
    let objective: String
    let challenge: String
    let options: [String]
    let answer: Int
    let explanation: String
    let labTitle: String
    let labDescription: String
    let labOptions: [String]
    let labAnswer: Int
    let labExplanation: String
}

private let lessons: [Lesson] = [
    Lesson(
        id: 1,
        title: "Fundamentos",
        subtitle: "Protege as tuas contas",
        icon: "lock.shield.fill",
        concept: "Uma palavra-passe forte deve ser difícil de adivinhar e exclusiva para cada conta. Um gestor de palavras-passe e a autenticação multifator acrescentam proteção.",
        objective: "Identificar práticas que reduzem o risco de acesso não autorizado.",
        challenge: "Qual destas práticas oferece melhor proteção?",
        options: [
            "Usar a mesma palavra-passe em todos os sites",
            "Usar palavras-passe únicas e autenticação multifator",
            "Partilhar a palavra-passe com um amigo de confiança"
        ],
        answer: 1,
        explanation: "Correto. Palavras-passe únicas limitam o impacto de uma fuga de dados. A autenticação multifator acrescenta uma camada de proteção.",
        labTitle: "Laboratório: auditor de contas",
        labDescription: "Uma conta fictícia usa a palavra-passe 'Moz2026' em cinco serviços e não tem segundo fator. Qual é a primeira melhoria recomendada?",
        labOptions: [
            "Manter a palavra-passe porque tem números",
            "Reutilizá-la apenas em sites conhecidos",
            "Criar palavras-passe únicas e ativar MFA"
        ],
        labAnswer: 2,
        labExplanation: "Boa decisão. O comprimento, a exclusividade e a proteção adicional são mais importantes do que simplesmente acrescentar um número."
    ),
    Lesson(
        id: 2,
        title: "Detetar phishing",
        subtitle: "Investiga mensagens suspeitas",
        icon: "envelope.badge.shield.half.filled",
        concept: "Phishing é uma tentativa de enganar alguém para revelar dados ou executar uma ação. Urgência, remetentes inesperados e links com domínios estranhos são sinais de alerta.",
        objective: "Reconhecer indícios de fraude antes de interagir com uma mensagem.",
        challenge: "Recebes uma mensagem: 'A tua conta será bloqueada em 10 minutos! Abre já este link desconhecido.' O que fazes?",
        options: [
            "Abrir rapidamente para evitar o bloqueio",
            "Responder com a palavra-passe para confirmar a conta",
            "Não abrir o link e verificar pelo canal oficial"
        ],
        answer: 2,
        explanation: "Correto. A pressão para agir depressa é uma técnica comum. Verifica a situação através da aplicação ou do site oficial, aberto por ti.",
        labTitle: "Laboratório: analisar um e-mail",
        labDescription: "E-mail fictício: 'Prémio confirmado! Envia o teu PIN M-Pesa para receberes o dinheiro.' Qual é o sinal mais importante?",
        labOptions: [
            "O pedido de um PIN confidencial",
            "A mensagem ter poucas palavras",
            "O texto mencionar um prémio"
        ],
        labAnswer: 0,
        labExplanation: "Nunca partilhes PINs ou códigos de autenticação para receber um prémio. A mensagem deve ser tratada como suspeita."
    ),
    Lesson(
        id: 3,
        title: "Segurança Web",
        subtitle: "Compreende entradas inseguras",
        icon: "chevron.left.forwardslash.chevron.right",
        concept: "Uma aplicação não deve confiar automaticamente nos dados recebidos. Consultas SQL parametrizadas separam os dados do código e ajudam a prevenir SQL injection.",
        objective: "Distinguir a construção insegura de consultas de uma abordagem parametrizada.",
        challenge: "Qual é a melhor forma de executar uma consulta SQL com um nome introduzido pelo utilizador?",
        options: [
            "Concatenar diretamente o texto na consulta",
            "Usar parâmetros e validar os dados",
            "Remover todos os espaços do texto"
        ],
        answer: 1,
        explanation: "Correto. Os parâmetros mantêm a entrada como dado, em vez de a interpretar como parte da instrução SQL.",
        labTitle: "Laboratório: formulário de pesquisa",
        labDescription: "Num simulador local, o campo de pesquisa recebe texto inesperado. Qual alteração melhora a segurança do backend?",
        labOptions: [
            "Esconder o campo no ecrã",
            "Confiar na validação feita apenas pelo iPhone",
            "Usar consultas parametrizadas no servidor"
        ],
        labAnswer: 2,
        labExplanation: "A validação no cliente melhora a experiência, mas pode ser contornada. A aplicação deve proteger a consulta também no servidor."
    ),
    Lesson(
        id: 4,
        title: "Análise de logs",
        subtitle: "Investiga eventos suspeitos",
        icon: "waveform.path.ecg",
        concept: "Os logs registam acontecimentos como autenticações e falhas. Uma sequência de muitas falhas seguida de um acesso bem-sucedido pode justificar uma investigação.",
        objective: "Identificar padrões anormais em registos de autenticação.",
        challenge: "Qual evento merece maior investigação?",
        options: [
            "Um acesso habitual do utilizador",
            "Vinte falhas de login e depois um sucesso na mesma conta",
            "Uma saída normal da aplicação"
        ],
        answer: 1,
        explanation: "Correto. A sequência pode indicar uma tentativa de adivinhar credenciais. É necessário verificar contexto, origem e outros eventos.",
        labTitle: "Laboratório: painel de eventos",
        labDescription: "Registos fictícios: 09:00 sucesso; 09:01 falha; 09:02 falha; 09:03 falha; 09:04 sucesso. Qual é a resposta inicial mais adequada?",
        labOptions: [
            "Ignorar porque houve um login bem-sucedido",
            "Apagar os logs para evitar alarmes",
            "Investigar a origem e rever a atividade da conta"
        ],
        labAnswer: 2,
        labExplanation: "Correto. Preserva os registos, verifica a origem e procura atividade adicional. Um padrão suspeito exige investigação, não uma conclusão automática."
    )
]

private enum Screen {
    case home, lesson(Int), lab(Int), result(Int, Bool)
}

@main
struct SwiftDemoApp: App {
    var body: some Scene {
        WindowGroup {
            CyberQuestView()
        }
    }
}

struct CyberQuestView: View {
    @AppStorage("cq.completed") private var completedRaw = ""
    @AppStorage("cq.xp") private var savedXP = 0

    @State private var screen: Screen = .home
    @State private var selected = -1
    @State private var labSelected = -1
    @State private var feedback = ""
    @State private var labFeedback = ""

    private var completed: Set<Int> {
        Set(completedRaw.split(separator: ",").compactMap { Int($0) })
    }

    private var xp: Int {
        max(savedXP, completed.count * 100)
    }

    private func unlocked(_ id: Int) -> Bool {
        id == 1 || completed.contains(id - 1)
    }

    private func markCompleted(_ id: Int) {
        var values = completed
        values.insert(id)
        completedRaw = values.sorted().map(String.init).joined(separator: ",")
        savedXP = max(savedXP, values.count * 100)
    }

    var body: some View {
        ZStack {
            CQ.bg.ignoresSafeArea()

            VStack(spacing: 0) {
                header

                switch screen {
                case .home:
                    home
                case .lesson(let id):
                    lessonView(lessons[id - 1])
                case .lab(let id):
                    labView(lessons[id - 1])
                case .result(let id, let success):
                    resultView(lessons[id - 1], success: success)
                }
            }
        }
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        HStack(spacing: 11) {
            Image(systemName: "shield.lefthalf.filled")
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(CQ.green)

            VStack(alignment: .leading, spacing: 2) {
                Text("CYBERQUEST")
                    .font(.system(size: 17, weight: .black, design: .monospaced))
                    .tracking(1.4)
                Text("ACADEMIA DE CIBERSEGURANÇA")
                    .font(.system(size: 9, weight: .bold))
                    .tracking(1)
                    .foregroundStyle(CQ.muted)
            }

            Spacer()

            HStack(spacing: 5) {
                Image(systemName: "bolt.fill")
                    .foregroundStyle(CQ.green)
                Text("\(xp) XP")
                    .fontWeight(.bold)
            }
            .font(.system(size: 12, design: .monospaced))
            .padding(10)
            .background(CQ.panel, in: Capsule())
        }
        .padding(.horizontal, 19)
        .padding(.vertical, 15)
        .background(CQ.bg)
        .overlay(alignment: .bottom) {
            Rectangle().fill(CQ.green.opacity(0.18)).frame(height: 1)
        }
    }

    private var home: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 9) {
                    Text("TREINO DE SEGURANÇA // 001")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .tracking(1.4)
                        .foregroundStyle(CQ.green)

                    Text("Aprende.\nPratica. Protege.")
                        .font(.system(size: 34, weight: .black))
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Quatro missões práticas para desenvolver o teu pensamento de segurança.")
                        .font(.system(size: 14))
                        .foregroundStyle(CQ.muted)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.top, 23)

                VStack(alignment: .leading, spacing: 13) {
                    HStack {
                        Text("PROGRESSO DO TREINO")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .tracking(1)
                            .foregroundStyle(CQ.muted)
                        Spacer()
                        Text("\(completed.count)/4")
                            .foregroundStyle(CQ.green)
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                    }

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(.white.opacity(0.08))
                            Capsule()
                                .fill(CQ.green)
                                .frame(width: geo.size.width * CGFloat(completed.count) / 4)
                        }
                    }
                    .frame(height: 7)

                    HStack {
                        Label("\(completed.count) concluídas", systemImage: "checkmark.circle.fill")
                        Spacer()
                        Text("MODO OFFLINE")
                    }
                    .font(.system(size: 10, weight: .medium, design: .monospaced))
                    .foregroundStyle(CQ.muted)
                }
                .padding(17)
                .background(CQ.panel, in: RoundedRectangle(cornerRadius: 17))

                HStack {
                    Text("TRILHO DE APRENDIZAGEM")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .tracking(1)
                    Spacer()
                    Text("4 MISSÕES")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(CQ.green)
                }

                ForEach(lessons) { item in
                    lessonCard(item)
                }

                if completed.count == lessons.count {
                    VStack(spacing: 10) {
                        Image(systemName: "trophy.fill")
                            .font(.system(size: 34))
                            .foregroundStyle(CQ.green)
                        Text("MISSÃO CONCLUÍDA")
                            .font(.system(size: 19, weight: .black, design: .monospaced))
                        Text("Completaste as quatro aulas do CYBERQUEST.")
                            .font(.system(size: 13))
                            .foregroundStyle(CQ.muted)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(25)
                    .background(CQ.panel, in: RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(.horizontal, 19)
            .padding(.bottom, 30)
        }
    }

    private func lessonCard(_ item: Lesson) -> some View {
        let isDone = completed.contains(item.id)
        let isUnlocked = unlocked(item.id)

        return Button {
            guard isUnlocked else { return }
            selected = -1
            feedback = ""
            screen = .lesson(item.id)
        } label: {
            HStack(spacing: 13) {
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .fill(isDone ? CQ.green.opacity(0.14) : CQ.bg)
                        .frame(width: 48, height: 48)
                    Image(systemName: isDone ? "checkmark" : item.icon)
                        .font(.system(size: 19, weight: .semibold))
                        .foregroundStyle(isDone ? CQ.green : (isUnlocked ? CQ.blue : CQ.muted))
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("NÍVEL \(String(format: "%02d", item.id))")
                        .font(.system(size: 9, weight: .bold, design: .monospaced))
                        .foregroundStyle(CQ.green)
                    Text(item.title)
                        .font(.system(size: 15, weight: .bold))
                    Text(item.subtitle)
                        .font(.system(size: 11))
                        .foregroundStyle(CQ.muted)
                }

                Spacer(minLength: 3)

                Image(systemName: isDone ? "checkmark.circle.fill" : (isUnlocked ? "arrow.up.right" : "lock.fill"))
                    .foregroundStyle(isDone ? CQ.green : CQ.muted)
            }
            .padding(14)
            .background(CQ.panel, in: RoundedRectangle(cornerRadius: 17))
            .overlay {
                RoundedRectangle(cornerRadius: 17)
                    .strokeBorder(isUnlocked ? CQ.green.opacity(0.13) : .white.opacity(0.04))
            }
            .opacity(isUnlocked ? 1 : 0.55)
        }
        .buttonStyle(.plain)
        .disabled(!isUnlocked)
    }

    private func lessonView(_ item: Lesson) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                backButton

                Text("NÍVEL \(String(format: "%02d", item.id)) / AULA")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .tracking(1.4)
                    .foregroundStyle(CQ.green)

                Text(item.title)
                    .font(.system(size: 30, weight: .black))

                VStack(alignment: .leading, spacing: 12) {
                    Label("CONCEITO-CHAVE", systemImage: "book.closed.fill")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundStyle(CQ.green)

                    Text(item.concept)
                        .font(.system(size: 15))
                        .lineSpacing(5)

                    Divider().overlay(.white.opacity(0.08))

                    Text("OBJETIVO")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundStyle(CQ.blue)

                    Text(item.objective)
                        .font(.system(size: 13))
                        .foregroundStyle(CQ.muted)
                }
                .padding(18)
                .background(CQ.panel, in: RoundedRectangle(cornerRadius: 18))

                Text("VERIFICA O QUE APRENDESTE")
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                    .foregroundStyle(CQ.muted)

                Text(item.challenge)
                    .font(.system(size: 16, weight: .semibold))
                    .fixedSize(horizontal: false, vertical: true)

                ForEach(item.options.indices, id: \.self) { index in
                    optionButton(item.options[index], index: index, chosen: selected)
                }

                if !feedback.isEmpty {
                    feedbackCard(feedback, success: selected == item.answer)
                }

                primaryButton(feedback.isEmpty ? "Verificar resposta" : "Continuar para o laboratório") {
                    if feedback.isEmpty {
                        guard selected >= 0 else {
                            feedback = "Escolhe uma resposta para continuar."
                            return
                        }
                        feedback = item.explanation
                    } else {
                        labSelected = -1
                        labFeedback = ""
                        screen = .lab(item.id)
                    }
                }
                .disabled(selected < 0 && feedback.isEmpty)
            }
            .padding(20)
            .padding(.bottom, 30)
        }
    }

    private func labView(_ item: Lesson) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                backButton

                HStack(spacing: 9) {
                    Image(systemName: "terminal.fill")
                        .foregroundStyle(CQ.green)
                    Text("LABORATÓRIO // SIMULAÇÃO LOCAL")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundStyle(CQ.green)
                }

                Text(item.labTitle)
                    .font(.system(size: 27, weight: .black))
                    .fixedSize(horizontal: false, vertical: true)

                Text("AMBIENTE FICTÍCIO • SEM LIGAÇÃO A SISTEMAS REAIS")
                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                    .foregroundStyle(CQ.muted)

                Text(item.labDescription)
                    .font(.system(size: 15))
                    .lineSpacing(4)
                    .padding(17)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(CQ.panel, in: RoundedRectangle(cornerRadius: 16))

                Text("ESCOLHE A TUA AÇÃO")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundStyle(CQ.muted)

                ForEach(item.labOptions.indices, id: \.self) { index in
                    optionButton(item.labOptions[index], index: index, chosen: labSelected)
                }

                if !labFeedback.isEmpty {
                    feedbackCard(labFeedback, success: labSelected == item.labAnswer)
                }

                primaryButton(labFeedback.isEmpty ? "Executar decisão" : "Concluir missão") {
                    if labFeedback.isEmpty {
                        guard labSelected >= 0 else {
                            labFeedback = "Seleciona uma ação antes de executar."
                            return
                        }
                        labFeedback = item.labExplanation
                    } else {
                        markCompleted(item.id)
                        screen = .result(item.id, labSelected == item.labAnswer)
                    }
                }
                .disabled(labSelected < 0 && labFeedback.isEmpty)
            }
            .padding(20)
            .padding(.bottom, 30)
        }
    }

    private func resultView(_ item: Lesson, success: Bool) -> some View {
        VStack(spacing: 22) {
            Spacer()

            Image(systemName: success ? "checkmark.seal.fill" : "flag.fill")
                .font(.system(size: 65))
                .foregroundStyle(CQ.green)

            Text("MISSÃO REGISTADA")
                .font(.system(size: 24, weight: .black, design: .monospaced))
                .multilineTextAlignment(.center)

            Text(success
                 ? "Boa decisão. Concluíste o laboratório e desbloqueaste o próximo nível."
                 : "Terminaste o laboratório. Revê a explicação e continua a aprender.")
                .font(.system(size: 14))
                .foregroundStyle(CQ.muted)
                .multilineTextAlignment(.center)
                .lineSpacing(4)

            HStack(spacing: 9) {
                Image(systemName: "bolt.fill")
                    .foregroundStyle(CQ.green)
                Text("+\(completed.contains(item.id) ? 100 : 0) XP TOTAL: \(xp)")
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .background(CQ.panel, in: RoundedRectangle(cornerRadius: 14))

            Spacer()

            primaryButton(item.id == 4 ? "Voltar ao painel" : "Continuar aprendizagem") {
                screen = .home
            }
        }
        .padding(23)
    }

    private var backButton: some View {
        Button {
            screen = .home
        } label: {
            Label("Painel", systemImage: "arrow.left")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(CQ.muted)
        }
        .buttonStyle(.plain)
    }

    private func optionButton(_ title: String, index: Int, chosen: Int) -> some View {
        Button {
            if case .lesson = screen, feedback.isEmpty {
                selected = index
            } else if case .lab = screen, labFeedback.isEmpty {
                labSelected = index
            }
        } label: {
            HStack(spacing: 11) {
                Image(systemName: chosen == index ? "largecircle.fill.circle" : "circle")
                    .foregroundStyle(chosen == index ? CQ.green : CQ.muted)
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)
                Spacer(minLength: 0)
            }
            .padding(14)
            .background(chosen == index ? CQ.green.opacity(0.09) : CQ.panel,
                        in: RoundedRectangle(cornerRadius: 13))
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .strokeBorder(chosen == index ? CQ.green.opacity(0.65) : .white.opacity(0.05))
            }
        }
        .buttonStyle(.plain)
    }

    private func feedbackCard(_ message: String, success: Bool) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: success ? "checkmark.circle.fill" : "info.circle.fill")
                .foregroundStyle(success ? CQ.green : CQ.blue)
            Text(message)
                .font(.system(size: 12))
                .lineSpacing(3)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(CQ.panel, in: RoundedRectangle(cornerRadius: 13))
    }

    private func primaryButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                Image(systemName: "arrow.right")
                Spacer()
            }
            .padding(16)
            .foregroundStyle(CQ.bg)
            .background(CQ.green, in: RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}
