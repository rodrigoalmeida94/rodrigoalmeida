const searchInput = document.getElementById('search-input');
const searchResults = document.getElementById('search-results');

let fuse;

async function initSearch() {
    try {
        const response = await fetch('/index.json');
        const data = await response.json();

        const options = {
            keys: ['title', 'contents', 'tags', 'categories'],
            threshold: 0.3,
            ignoreLocation: true
        };

        fuse = new Fuse(data, options);

        searchInput.addEventListener('input', (e) => {
            const query = e.target.value;
            if (query.length > 2) {
                const results = fuse.search(query);
                displayResults(results);
            } else {
                searchResults.innerHTML = '';
            }
        });
    } catch (error) {
        console.error("Error loading search index:", error);
    }
}

function displayResults(results) {
    if (results.length === 0) {
        searchResults.innerHTML = '<p>No results found.</p>';
        return;
    }

    let html = '';
    results.forEach(result => {
        const item = result.item;
        html += `
            <div class="search-result-item">
                <h3><a href="${item.permalink}">${item.title}</a></h3>
                <p>${item.contents.substring(0, 150)}...</p>
                <small>${item.date ? new Date(item.date).toLocaleDateString() : ''}</small>
            </div>
        `;
    });

    searchResults.innerHTML = html;
}

document.addEventListener('DOMContentLoaded', initSearch);
