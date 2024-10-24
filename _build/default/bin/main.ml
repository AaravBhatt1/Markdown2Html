open Markdown2Html.Reader
open Markdown2Html.Writer

let () =
  let filepath = Sys.argv.(1) in
  let ic = open_in filepath in
  let mdContents = really_input_string ic (in_channel_length ic)
  in close_in ic;
  let readMd = mdContents |> String.to_seq |> parseText in
  let writeHtml = readMd |> convertLines |> (Seq.fold_left String.cat "") in
  let html_filepath = Filename.remove_extension filepath ^ ".html" in
  let oc = open_out html_filepath in
  output_string oc writeHtml;
  close_out oc;
