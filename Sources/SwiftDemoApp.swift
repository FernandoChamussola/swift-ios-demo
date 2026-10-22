
import SwiftUI

private enum AppStyle {
    static let blue = Color(red: 0.20, green: 0.38, blue: 0.95)
    static let background = Color(red: 0.96, green: 0.97, blue: 0.99)
    static let muted = Color(red: 0.43, green: 0.47, blue: 0.55)
}

private enum Priority: String, CaseIterable, Codable {
    case low = "Baixa"
    case medium = "Média"
    case high = "Alta"

    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .orange
        case .high: return .red
        }
    }

    var symbol: String {
        switch self {
        case .low: return "arrow.down"
        case .medium: return "minus"
        case .high: return "arrow.up"
        }
    }
}

private struct TaskItem: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var priority: Priority = .medium
    var isCompleted: Bool = false
}

private enum TaskFilter: String, CaseIterable {
    case all = "Todas"
    case pending = "Pendentes"
    case completed = "Concluídas"
}

@main
struct SwiftDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @AppStorage("taskManager.name") private var userName = "Fernando"
    @State private var tasks: [TaskItem] = []
    @State private var newTitle = ""
    @State private var newPriority: Priority = .medium
    @State private var selectedFilter: TaskFilter = .all
    @State private var showAddTask = false
    @State private var hasLoaded = false

    private var completedCount: Int {
        tasks.filter(\.isCompleted).count
    }

    private var pendingCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }

    private var progress: Double {
        tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count)
    }

    private var visibleTasks: [TaskItem] {
        let filtered = tasks.filter { task in
            switch selectedFilter {
            case .all: return true
            case .pending: return !task.isCompleted
            case .completed: return task.isCompleted
            }
        }

        return filtered.sorted {
            if $0.isCompleted != $1.isCompleted {
                return !$0.isCompleted
            }
            let order: [Priority: Int] = [
                .high: 0, .medium: 1, .low: 2
            ]
            return order[$0.priority, default: 1] <
                   order[$1.priority, default: 1]
        }
    }

    var body: some View {
        ZStack {
            AppStyle.background.ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        welcomeSection
                        progressCard
                        filterSection
                        taskSection
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 22)
                    .padding(.bottom, 32)
                }

                addButton
            }
        }
        .preferredColorScheme(.light)
        .onAppear(perform: loadTasks)
        .sheet(isPresented: $showAddTask) {
            addTaskSheet
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    private var header: some View {
        HStack {
            HStack(spacing: 10) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppStyle.blue)
                        .frame(width: 42, height: 42)

                    Image(systemName: "checkmark")
                        .font(.system(size: 21, weight: .bold))
                        .foregroundStyle(.white)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("TaskFlow")
                        .font(.system(size: 20, weight: .bold))

                    Text("GESTÃO DE TAREFAS")
                        .font(.system(size: 9, weight: .bold))
                        .tracking(1.5)
                        .foregroundStyle(AppStyle.muted)
                }
            }

            Spacer()

            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 35))
                .foregroundStyle(AppStyle.blue.opacity(0.85))
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 14)
        .background(.white)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.black.opacity(0.04))
                .frame(height: 1)
        }
    }

    private var welcomeSection: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(Date.now.formatted(
                .dateTime.weekday(.wide).day().month(.wide)
            ).uppercased())
            .font(.system(size: 10, weight: .bold))
            .tracking(1.3)
            .foregroundStyle(AppStyle.blue)

            Text("Olá, \(userName) 👋")
                .font(.system(size: 29, weight: .bold))
                .foregroundStyle(Color.primary)

            Text(pendingCount == 0
                 ? "Tudo em dia. Aproveita o teu tempo!"
                 : "Tens \(pendingCount) tarefa(s) por concluir.")
                .font(.system(size: 14))
                .foregroundStyle(AppStyle.muted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 17) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("O teu progresso")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)

                    Text("\(completedCount) de \(tasks.count) concluídas")
                        .font(.system(size: 12))
                        .foregroundStyle(.white.opacity(0.75))
                }

                Spacer()

                Text("\(Int(progress * 100))%")
                    .font(.system(size: 27, weight: .bold))
                    .foregroundStyle(.white)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.white.opacity(0.22))

                    Capsule()
                        .fill(.white)
                        .frame(width: geometry.size.width * progress)
                }
            }
            .frame(height: 7)

            HStack(spacing: 18) {
                Label("\(pendingCount) pendentes", systemImage: "clock")
                Label("\(completedCount) feitas", systemImage: "checkmark.circle")
            }
            .font(.system(size: 11, weight: .medium))
            .foregroundStyle(.white.opacity(0.9))
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 22)
                .fill(
                    LinearGradient(
                        colors: [
                            AppStyle.blue,
                            Color(red: 0.34, green: 0.43, blue: 0.96)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }

    private var filterSection: some View {
        HStack(spacing: 8) {
            ForEach(TaskFilter.allCases, id: \.self) { filter in
                Button {
                    selectedFilter = filter
                } label: {
                    Text(filter.rawValue)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(
                            selectedFilter == filter
                            ? .white : AppStyle.muted
                        )
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background {
                            Capsule()
                                .fill(
                                    selectedFilter == filter
                                    ? AppStyle.blue : .white
                                )
                        }
                        .overlay {
                            Capsule()
                                .strokeBorder(
                                    selectedFilter == filter
                                    ? .clear : Color.black.opacity(0.05)
                                )
                        }
                }
                .buttonStyle(.plain)
            }

            Spacer(minLength: 0)
        }
    }

    private var taskSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("As minhas tarefas")
                    .font(.system(size: 18, weight: .bold))

                Spacer()

                Text("\(visibleTasks.count)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(AppStyle.blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(AppStyle.blue.opacity(0.09))
                    .clipShape(Capsule())
            }

            if visibleTasks.isEmpty {
                emptyState
            } else {
                ForEach(visibleTasks) { task in
                    taskRow(task)
                }
            }
        }
    }

    private func taskRow(_ task: TaskItem) -> some View {
        HStack(spacing: 12) {
            Button {
                toggleTask(task)
            } label: {
                Image(systemName: task.isCompleted
                      ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 23))
                    .foregroundStyle(
                        task.isCompleted ? .green : AppStyle.muted.opacity(0.65)
                    )
            }
            .buttonStyle(.plain)
            .accessibilityLabel(
                task.isCompleted ? "Reabrir tarefa" : "Concluir tarefa"
            )

            VStack(alignment: .leading, spacing: 7) {
                Text(task.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(
                        task.isCompleted ? AppStyle.muted : Color.primary
                    )
                    .strikethrough(task.isCompleted)

                HStack(spacing: 5) {
                    Image(systemName: task.priority.symbol)
                        .font(.system(size: 9, weight: .bold))

                    Text(task.priority.rawValue)
                        .font(.system(size: 10, weight: .semibold))
                }
                .foregroundStyle(task.priority.color)
            }

            Spacer(minLength: 2)

            Button(role: .destructive) {
                deleteTask(task)
            } label: {
                Image(systemName: "trash")
                    .font(.system(size: 14))
                    .foregroundStyle(AppStyle.muted.opacity(0.7))
                    .padding(8)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Eliminar \(task.title)")
        }
        .padding(15)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 17))
        .overlay {
            RoundedRectangle(cornerRadius: 17)
                .strokeBorder(Color.black.opacity(0.045))
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: selectedFilter == .completed
                  ? "checkmark.circle" : "tray")
                .font(.system(size: 35))
                .foregroundStyle(AppStyle.blue.opacity(0.65))

            Text(selectedFilter == .completed
                 ? "Ainda não concluíste tarefas"
                 : selectedFilter == .pending
                 ? "Não tens tarefas pendentes"
                 : "Começa por adicionar uma tarefa")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(AppStyle.muted)

            Text("Organiza o teu dia, uma tarefa de cada vez.")
                .font(.system(size: 12))
                .foregroundStyle(AppStyle.muted.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .padding(.horizontal, 15)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private var addButton: some View {
        Button {
            newTitle = ""
            newPriority = .medium
            showAddTask = true
        } label: {
            HStack(spacing: 9) {
                Image(systemName: "plus")
                    .font(.system(size: 15, weight: .bold))

                Text("Adicionar tarefa")
                    .font(.system(size: 15, weight: .bold))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
            .background(AppStyle.blue)
            .clipShape(RoundedRectangle(cornerRadius: 17))
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 22)
        .padding(.top, 12)
        .padding(.bottom, 10)
        .background(.white)
    }

    private var addTaskSheet: some View {
        NavigationStack {
            Form {
                Section("Detalhes da tarefa") {
                    TextField("Ex.: Estudar SwiftUI", text: $newTitle)
                        .submitLabel(.done)

                    Picker("Prioridade", selection: $newPriority) {
                        ForEach(Priority.allCases, id: \.self) { priority in
                            Text(priority.rawValue).tag(priority)
                        }
                    }
                }

                Section {
                    Label(
                        "A tarefa será guardada neste dispositivo.",
                        systemImage: "lock.shield"
                    )
                    .font(.footnote)
                    .foregroundStyle(AppStyle.muted)
                }
            }
            .navigationTitle("Nova tarefa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        showAddTask = false
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        addTask()
                    }
                    .disabled(newTitle.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty)
                    .fontWeight(.semibold)
                }
            }
        }
        .tint(AppStyle.blue)
    }

    private func addTask() {
        let title = newTitle.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !title.isEmpty else { return }

        tasks.insert(
            TaskItem(title: title, priority: newPriority),
            at: 0
        )

        saveTasks()
        selectedFilter = .all
        showAddTask = false
    }

    private func toggleTask(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id })
        else { return }

        tasks[index].isCompleted.toggle()
        saveTasks()
    }

    private func deleteTask(_ task: TaskItem) {
        tasks.removeAll { $0.id == task.id }
        saveTasks()
    }

    private func loadTasks() {
        guard !hasLoaded else { return }
        hasLoaded = true

        if let data = UserDefaults.standard.data(forKey: "taskManager.tasks"),
           let savedTasks = try? JSONDecoder().decode(
                [TaskItem].self, from: data
           ) {
            tasks = savedTasks
        } else {
            tasks = [
                TaskItem(title: "Planear o meu dia", priority: .high),
                TaskItem(title: "Estudar SwiftUI", priority: .medium),
                TaskItem(title: "Organizar apontamentos", priority: .low)
            ]
            saveTasks()
        }
    }

    private func saveTasks() {
        guard let data = try? JSONEncoder().encode(tasks) else { return }
        UserDefaults.standard.set(data, forKey: "taskManager.tasks")
    }
}
