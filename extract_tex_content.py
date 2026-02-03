#!/usr/bin/env python3
import sys
import re
import os

def extract_content(input_file):
    if not os.path.exists(input_file):
        print(f"Error: File '{input_file}' not found.")
        return

    basename = os.path.splitext(os.path.basename(input_file))[0]
    output_file = f"{basename}_extracted.tex"

    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()

    # Regex for finding the preamble (everything before \begin{document})
    preamble_match = re.search(r'(.*?)\\begin\{document\}', content, re.DOTALL)
    if not preamble_match:
        print("Error: Could not find \\begin{document}.")
        return

    preamble = preamble_match.group(1)
    
    # Modify documentclass to be onecolumn
    # Look for \documentclass[...]{IEEEtran} or just \documentclass{IEEEtran}
    if 'onecolumn' not in preamble:
        preamble = re.sub(r'\\documentclass\[(.*?)\]\{IEEEtran\}', r'\\documentclass[\1,onecolumn]{IEEEtran}', preamble)
        # Handle case where there are no options
        if 'onecolumn' not in preamble: # check if previous sub worked
             preamble = re.sub(r'\\documentclass\{IEEEtran\}', r'\\documentclass[onecolumn]{IEEEtran}', preamble)
    
    # Find CJK wrapper if it exists inside document to preserve it
    # We'll just look for \begin{CJK}{UTF8}{bsmi} ... \end{CJK} structure if it's common
    # Or simplified: We just put the extracted content inside CJK environment if we see usepackage CJK
    use_cjk = r'\usepackage{CJK}' in preamble or r'\usepackage[encapsulated]{CJK}' in preamble
    
    extracted_items = []

    # Regex for environments we want to capture
    # Captures \begin{env} ... \end{env} including nested content
    # We use a list of environment names
    env_names = [
        'table', 'table\*', 
        'equation', 'equation\*', 
        'align', 'align\*', 
        'gather', 'gather\*', 
        'multline', 'multline\*',
        'figure', 'figure\*' # Added figures just in case, though user asked for tables/formulas
    ]
    
    # Iterate through content to find these environments
    # We scan the body content
    body_content = content[preamble_match.end():]
    
    # Simple regex for top-level environments.
    pattern = r'\\begin\{(' + '|'.join(env_names) + r')\}(.*?)\\end\{\1\}'
    
    # The dot matches newlines with re.DOTALL
    matches = re.finditer(pattern, body_content, re.DOTALL)
    
    for match in matches:
        full_match = match.group(0)
        extracted_items.append(full_match)

    # Find bibliography commands
    bib_style_match = re.search(r'\\bibliographystyle\{.*?\}', content)
    bib_file_match = re.search(r'\\bibliography\{.*?\}', content)
    
    # Write output
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(preamble)
        f.write("\n\\begin{document}\n")
        
        if use_cjk:
            # Try to match the exact CJK line used in source if possible, else default
            cjk_start = r'\begin{CJK}{UTF8}{bsmi}'
            cjk_end = r'\end{CJK}'
            f.write(cjk_start + "\n")
        
        f.write("\\section*{Extracted Content}\n\n")
        
        for item in extracted_items:
            f.write(item)
            f.write("\n\n\\hrulefill\\par\\vspace{1cm}\n\n")
            
        # Add bibliography if found
        if bib_style_match:
            f.write("\n" + bib_style_match.group(0) + "\n")
        if bib_file_match:
            f.write(bib_file_match.group(0) + "\n")

        if use_cjk:
            f.write(cjk_end + "\n")
            
        f.write("\\end{document}\n")

    print(f"Successfully extracted {len(extracted_items)} items to '{output_file}'.")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 extract_tex_content.py <filename.tex>")
        # Default for this user
        default_file = "drafting.tex"
        if os.path.exists(default_file):
            print(f"No file specified. Using default: {default_file}")
            extract_content(default_file)
        else:
            sys.exit(1)
    else:
        extract_content(sys.argv[1])
