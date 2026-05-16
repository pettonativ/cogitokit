import os
import json
import requests
import sys
import argparse

def search_serper(query, api_key, num=10):
    url = "https://google.serper.dev/search"
    payload = json.dumps({
        "q": query,
        "num": num
    })
    headers = {
        'X-API-KEY': api_key,
        'Content-Type': 'application/json'
    }
    
    try:
        response = requests.post(url, headers=headers, data=payload)
        response.raise_for_status()
        data = response.json()
        
        results = []
        for item in data.get("organic", []):
            results.append({
                "title": item.get("title", ""),
                "link": item.get("link", ""),
                "snippet": item.get("snippet", "")
            })
        return results
    except Exception as e:
        print(json.dumps({"error": str(e)}), file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Serper.dev Search Utility for OSINT")
    parser.add_argument("query", help="The search query")
    parser.add_argument("--api_key", help="Serper.dev API Key (fallback to SERPER_API_KEY env var)")
    parser.add_argument("--num", type=int, default=10, help="Number of results (max 100)")
    
    args = parser.parse_args()
    
    api_key = args.api_key or os.environ.get("SERPER_API_KEY")
    if not api_key:
        # Per comodità nel workspace, usiamo la chiave fornita dall'utente se disponibile
        api_key = "fe5bd97a5483030a1253314b1155913181f6ae27" 
    
    results = search_serper(args.query, api_key, args.num)
    print(json.dumps(results, indent=2))
