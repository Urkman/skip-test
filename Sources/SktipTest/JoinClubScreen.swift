import SkipFuseUI

//@MainActor // FIX: include this line
struct JoinClubScreen: View {
    @Environment(\.customDismiss) var customDismiss

    @State var displayName: String = ""
    @State var searchQuery: String = ""
    @State var inviteCode: String = ""

    @State var searchResults: [Club] = []
    @State var selectedClub: Club?

    @State var isLoadingSearch: Bool = false
    @State var isLoadingJoin: Bool = false
    @State var errorMessage: String?

    var isFormValid: Bool {
        !displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        selectedClub != nil &&
        (selectedClub?.isPrivate == false || (selectedClub?.isPrivate == true && !inviteCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty))
    }

    var body: some View {
        FormSheetView(
            title: {
                Text("Join Club")
            },
            body: {
                mainBodyContent
            },
            footer: {
                FormActionButton(
                    title: "Join Club",
                    isLoading: isLoadingJoin,
                    isDisabled: !isFormValid || isLoadingJoin
                ) {
                    Task { await performJoinClub() }
                }
            }
        )
    }

    private var mainBodyContent: some View {
        Form {
            userDetailsSection
            findClubSection
            inviteCodeSection
            errorDisplaySection
        }
    }

    private var userDetailsSection: some View {
        Section(header: Text("Your Details")) {
            TextField("Display Name", text: $displayName)
                .autocorrectionDisabled(true) // Autocorrection is fine
        }
    }

    private var findClubSection: some View {
        Section(header: Text("Find a Club")) {
            VStack {
                searchSectionHeader

                if isLoadingSearch {
                    loadingView
                } else if !searchResults.isEmpty {
                    searchResultList

                    // FIX
                    // change this:
                } else if !searchQuery.isEmpty {
                     Text("Nothing found")

                    // to this:
//                } else {
//                    if !searchQuery.isEmpty {
//                        Text("Nothing found")
//                    }
                }
            }
        }
    }

    private var loadingView: some View {
        VStack {
            ProgressView()
            Text("Searching clubs...")
                .foregroundColor(Color.secondaryText)
        }
    }

    private var searchSectionHeader: some View {
        HStack {
            TextField("Search by club name", text: $searchQuery)
                .autocorrectionDisabled(true)
            Button(action: {
                Task { await performSearchClubs() }
            }) {
                if isLoadingSearch {
                    ProgressView()
                        .progressViewStyle(.circular) // Explicit style
                } else {
                    Image(systemName: "magnifyingglass")
                }
            }
            .disabled(searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoadingSearch)
        }
    }

    private var searchResultList: some View {
        LazyVStack {
            ForEach(searchResults) { club in
                ClubSearchRow(
                    club: club,
                    isSelected: selectedClub?.id == club.id
                ) {
                    Task { await selectClub(club) }
                }
            }
        }
    }

    private var noClubsFoundSection: some View {
        Text("No clubs found for \"\(searchQuery)\".")
            .foregroundColor(Color.secondaryText)
            .font(.caption)
    }

    @ViewBuilder
    private var inviteCodeSection: some View {
        if let club = selectedClub, club.isPrivate {
            Section(header: Text("Private Club Access for \(club.name)")) {
                TextField("Invite Code", text: $inviteCode)
                    .autocorrectionDisabled(true)
            }
            .transition(.opacity.combined(with: .move(edge: .top)))
        }
    }

    @ViewBuilder
    private var errorDisplaySection: some View {
        if let errorMessage, !errorMessage.isEmpty {
            Section {
                Text(errorMessage)
                    .foregroundColor(Color.error)
            }
        }
    }

    @MainActor
    private func selectClub(_ club: Club) {
        if selectedClub?.id == club.id {
            selectedClub = nil
            inviteCode = ""
        } else {
            selectedClub = club

            if !club.isPrivate {
                inviteCode = ""
            }
        }
    }

    @MainActor
    private func performSearchClubs() async {
    }

    @MainActor
    private func performJoinClub() async {
    }
}

struct ClubSearchRow: View {
    let club: Club
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: AppSpacing.Spacing.extraSmall) {
                Text(club.name)
                    .font(.headline)
                    .foregroundColor(Color.text)

                HStack(spacing: AppSpacing.Spacing.small) {
                    Text(club.isPrivate ? "Private" : "Public")
                        .font(.caption)
                        .foregroundColor(Color.secondaryText)

                    Text("•")
                        .font(.caption)
                        .foregroundColor(Color.secondaryText)

                    Text("Created: \(formatDate(club.createdAt))")
                        .font(.caption)
                        .foregroundColor(Color.secondaryText)
                }
            }

            Spacer()

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color.accent)
                    .font(.system(size: AppSpacing.IconSize.small))
            }
        }
        .padding(.vertical, AppSpacing.Padding.small)
        .onTapGesture {
            onTap()
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
